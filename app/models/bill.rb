class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence


  after_create :create_event_recurrence
  after_create :send_text_message


  validates :name, presence: true
  validates :duedate, presence: true

  attr_accessor :date


  # scope :due_this_week, -> do
  #   where duedate: (Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday))
  # end

  def self.due_this_week
    all_week = Date.current.all_week.to_a
    Bill.all.select { |bill| 
      (bill.dates & all_week).any?
    }
  end

  # def self.due_this_week
  #   where(duedate: (Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday)))
  # end

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
    # recurrence doesn't count now in the time period
    event_recurrence.start_date = case self.every
      when 'year'
         Time.now.last_year
      when 'month'
        Time.now.last_month 
      when 'week'
        Time.now.last_week
      when 'day'
        Time.now.yesterday
      end
    event_recurrence.save
  end

  def dates(options={})
    self.event_recurrence.dates(options)
  end
end



