class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_one :event_recurrence


  after_create :event_recurrence

  validates :name, presence: true
  validates :duedate, presence: true


  scope :due_this_week, -> do
    where duedate: (Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday))
  end

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

  def event_recurrence
    event_recurrence = EventRecurrence.new
    event_recurrence.bill_id = self.id
    event_recurrence.start_date = Time.now
    event_recurrence.end_date = 1.year.from_now
    event_recurrence.every = self.every
    event_recurrence.save
  end
end


# OR Category LIKE ?
#enable search bar to search through categories as well

