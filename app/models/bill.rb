class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence, :dependent => :destroy


  after_create :create_event_recurrence
  after_destroy :delete_recurrence
  
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

    HTTParty.post("http://localhost:8080/event_recurrences.json", 
        :body => {'bill_id' => self.id,
          'end_date' => 1.year.from_now,
           'every' => self.every,
            'start_date' => self.duedate,
            'interval' => self.interval }.to_json, 
        
        :headers => { 'Content-Type' => 'application/json',
         'Accept' => "application/json" } )
    
  end

  def delete_recurrence
    response = HTTParty.get("http://localhost:8080/event_recurrences.json")
    puts "----------"
    # puts response.body.class
    a = JSON.parse(response.body)
    a.each do |hash|
     if hash['bill_id'] == self.id.to_s
      @match = hash
      end
    end
  

    
    HTTParty.delete("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'bill_id' => self.id,
    'end_date' => 1.year.from_now,
    'every' => self.every,
    'start_date' => self.duedate,
    'interval' => self.interval }.to_json, 

    :headers => { 'Content-Type' => 'application/json',
    'Accept' => "application/json" } )
  end
end



