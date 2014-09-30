class Category < ActiveRecord::Base
	has_many :providers
	validates :name, presence: true
end
