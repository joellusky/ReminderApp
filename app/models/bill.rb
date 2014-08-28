class Bill < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reminders

end
