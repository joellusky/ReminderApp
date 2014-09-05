class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  

  validates :name, presence: true

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
end


# OR Category LIKE ?
#enable search bar to search through categories as well

