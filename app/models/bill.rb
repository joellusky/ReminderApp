require 'rubygems'
require 'twilio-ruby'

class Bill < ActiveRecord::Base
  has_one :category, through: :provider
  belongs_to :user
  belongs_to :provider
  has_many :reminders,
  		:dependent => :destroy

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

