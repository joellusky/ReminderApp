class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence, :dependent => :destroy


  after_create :create_event_recurrence
  after_destroy :delete_recurrence
  after_update :update_recurrence

  
  validates :every, presence: true
  validates :provider_id, presence: true
  validates :user_id, presence: true
  validates :duedate, presence: true
  validates :contact_method, presence: true

  attr_accessor :date


  #search method
	def self.search(search)
  	unless search.blank?
  		search = "%#{search}%"
  		where('Name LIKE ? ', search)
  	else
  		all
  		# where(user_id: current_user.id)
  	end
	end

  def create_event_recurrence
    event_recurrence = EventRecurrence.new
    event_recurrence.bill_id = self.id
    event_recurrence.end_date = 1.year.from_now
    event_recurrence.every = self.every
    start = self.duedate

    # recurrence doesn't count now in the time period, so we need to go back 1 interval
    event_recurrence.start_date = case self.every
      when 'year'
        start.last_year
      when 'month'
        start.last_month 
      when 'twice a year'
        start.last_month + 1.month
      when 'every two weeks'
        start - 14.days
      when 'day'
        start.yesterday
      end

    event_recurrence.interval = 
      case self.every
        when 'every two weeks'
           2 #months
        when 'twice a year'
           6 #weeks 
      end

      event_recurrence.save

      send_recurrence
  end

  def dates(options={})
    self.event_recurrence.dates(options)
  end

  def send_recurrence
    begin
    HTTParty.post("http://localhost:8080/event_recurrences.json", 
        :body => {'bill_id' => self.id,
          'end_date' => 1.year.from_now,
           'every' => self.every,
            'start_date' => self.duedate,
            'interval' => self.interval }.to_json, 
        
        :headers => { 'Content-Type' => 'application/json',
         'Accept' => "application/json" } )
    rescue Exception => e
    end
    
  end

  def delete_recurrence
    begin
    response = HTTParty.get("http://localhost:8080/event_recurrences.json")
    # a is an array of hashes. each hash being an event recurrence. 
    a = JSON.parse(response.body)
    # a.each iterates over every hash in the response array.
    a.each do |hash|
      # if the hash has a key 'bill_id' whos value is equal to that of self.id
      if hash['bill_id'] == self.id.to_s
        # @match represents the hash of the event recurrence that needs to be deleted on reminderService, when a bill is deleted in ReminderApp
        @match = hash
      end
    end
  

    #initiaes a delete request and interpolates the value of key[ID], and does converts it to integer.
    HTTParty.delete("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'bill_id' => self.id,
    'end_date' => 1.year.from_now,
    'every' => self.every,
    'start_date' => self.duedate,
    'interval' => self.interval }.to_json, 

    :headers => { 'Content-Type' => 'application/json',
    'Accept' => "application/json" } )
    rescue Exception => e
    end
  end

  def update_recurrence
    begin
    response = HTTParty.get("http://localhost:8080/event_recurrences.json")
    a = JSON.parse(response.body)
    a.each do |hash|
      if hash['bill_id'] == self.id.to_s
        @match = hash
        
        # if self.duedate == @match['duedate']
            
        # else
        #   new_date = self.duedate
        # end

      end

    end
    
    HTTParty.patch("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'bill_id' => self.id,
    'end_date' => self.duedate + 1.year,
    'every' => self.every,
    'start_date' => self.duedate,
    'interval' => self.interval }.to_json, 

    :headers => { 'Content-Type' => 'application/json',
    'Accept' => "application/json" } )  
  end
    rescue Exception => e
    end
end



