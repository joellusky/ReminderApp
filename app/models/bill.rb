class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence, :dependent => :destroy


  after_create :create_event_recurrence
  

  validates :duedate, presence: true

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
  end

  def dates(options={})
    self.event_recurrence.dates(options)
  end

  # def self.date_past
  #   last_week = Date.current.last_week.all_week.to_a
  #   Bill.all.select { |bill| (bill.dates & last_week).any?}
  # end

end



