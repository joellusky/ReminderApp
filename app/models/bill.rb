class Bill < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reminders
  belongs_to :provider

  validates :name, presence: true

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

