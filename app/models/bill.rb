class Bill < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reminders



  #search method
  def self.search(search)
		unless search.blank?
			search = "%#{search}%"
			where('name LIKE ? ', search)
		else
			all
		end
	end

end


# OR Category LIKE ?
#enable search bar to search through categories as well

