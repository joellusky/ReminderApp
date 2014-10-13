class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence, :dependent => :destroy

  #create_event_recurrence creates the actual recurrence and 
  #also calls on send_recurrence at the end of the method
  after_create :create_event_recurrence
  after_destroy :delete_recurrence
  after_update :update_recurrence
  after_update :update_contact_method, :if => :contact_method_changed? 

  
  validates :every, presence: true
  validates :provider_id, presence: true
  validates :user_id, presence: true
  validates :duedate, presence: true
  validates :contact_method, presence: true

  attr_accessor :date

  @@token = "11bbad9f27d1494f8d8570db1ba4855a"

  #search method
	def self.search(search)
  	unless search.blank?
  		search = "%#{search}%"
  		where('Name LIKE ? ', search)
  	else
  		all
  	end
	end

  def create_event_recurrence
    event_recurrence = EventRecurrence.new
    event_recurrence.bill_id = self.id
    event_recurrence.end_date = 1.year.from_now
    event_recurrence.every = self.every
    start = self.duedate

    # recurrence doesn't count now in the time period, so we need to go back 1 interval
    event_recurrence.start_date = 
    case self.every
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
    2 #weeks
    when 'twice a year'
    6 #months 
    end

    event_recurrence.save

    send_recurrence
  end

  def dates(options={})
    self.event_recurrence.dates(options)
  end

  def send_recurrence
    if self.contact_method == 'text'
      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/texts.json", 
        :body => {
        'event_recurrence' => {
        'object_id' => self.id,
        'end_date' => 1.year.from_now,
        'every' => self.every,
        'start_date' => self.duedate}, 
        'text' => { 
        'cell_phone' => self.user.cell_phone,
        'text_reminder' => "This is a reminder that your #{self.provider.name} bill is due tomorrow. #{self.provider.url}"
        }
        }.to_json, 

        :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )

    elsif self.contact_method == 'phone call'
      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/calls.json", 
      :body => {
        'event_recurrence' => {
        'object_id' => self.id,
        'end_date' => 1.year.from_now,
        'every' => self.every,
        'start_date' => self.duedate}, 
        'call' => { 
        'cell_phone' => self.user.cell_phone,
        'call_reminder' => "Hello #{self.user.first_name}. This is a friendly reminder that your #{self.provider.name}, #{self.category.name} bill is due tomorrow. Thank you for using Forget Me Not. GoodBye!"
        }
        }.to_json, 

        :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )

    elsif self.contact_method == 'email'
      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/emails.json", 
        :body => {
        'event_recurrence' => {
        'object_id' => self.id,
        'end_date' => 1.year.from_now,
        'every' => self.every,
        'start_date' => self.duedate}, 
        'email' => { 
        'email_address' => self.user.email,
        'email_reminder' => "Hello #{self.user.first_name}. This is a friendly reminder that your #{self.provider.name}, #{self.category.name} bill is due tomorrow. Thank you for using Forget Me Not"

        }
        }.to_json, 

        :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )
    end
  end

  def delete_recurrence
    # a is an array of hashes. each hash being an event recurrence.
    # a.each iterates over every hash in the response array. 
    # if the hash has a key 'object_id' whos value is equal to that of bill.id
    # @match represents the instance on the API that needs to be deleted, when a bill is deleted in ReminderApp
    
    response = HTTParty.get("http://sleepy-citadel-7753.herokuapp.com/event_recurrences.json")
    a = JSON.parse(response.body)
    a.each do |hash|
      if hash['object_id'] == self.id.to_s
        @match = hash
      end
    end

    #Does the delete by inputting the instance ID of the object we are attempting to delete
    HTTParty.delete("http://sleepy-citadel-7753.herokuapp.com/event_recurrences/#{@match['id'].to_i}.json", 
      :body => {'object_id' => self.id }.to_json, 

      :headers => { 
      'Authorization' => "Token token=#{@@token}",
      'Content-Type' => 'application/json',
      'Accept' => "application/json" } )
  end

  def update_recurrence
    response = HTTParty.get("http://sleepy-citadel-7753.herokuapp.com/event_recurrences.json")
    a = JSON.parse(response.body)
    a.each do |hash|
      if hash['object_id'] == self.id.to_s
        @match = hash
      end
    end

    HTTParty.patch("http://sleepy-citadel-7753.herokuapp.com/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'object_id' => self.id,
    'end_date' => self.duedate + 1.year,
    'every' => self.every,
    'start_date' => self.duedate, 
    'cell_phone' => self.user.cell_phone,
    'email' => self.user.email }.to_json, 

    :headers => { 
    'Authorization' => "Token token=#{@@token}",
    'Content-Type' => 'application/json',
    'Accept' => "application/json" } )
  end

  #if a bill is updated with a new contact method, 
  #this method will delete the old instance and add a new one with the new contact 
  def update_contact_method
    delete_recurrence
    send_recurrence
  end
end



