class Category < ActiveRecord::Base
	has_many :bills
	has_many :providers
end
