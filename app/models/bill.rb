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

    SendJob.new.async.perform(self.id)
    # SendWorker.perform_async(self.id)
  end

  def dates(options={})
    self.event_recurrence.dates(options)
  end

  def delete_recurrence
    DeleteJob.new.async.perform(self.id)
    # DeleteWorker.perform_async(self.id)
  end

  def update_recurrence
    UpdateJob.new.async.perform(self.id)
    # UpdateWorker.perform_async(self.id)
  end

  #if a bill is updated with a new contact method, 
  #this method will delete the old instance and add a new one with the new contact 
  def update_contact_method
    DeleteJob.new.async.perform(self.id)
    SendJob.new.async.perform(self.id)
    # DeleteWorker.perform_async(self.id)
    # SendWorker.perform_async(self.id)
  end
end



