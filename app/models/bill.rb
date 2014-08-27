class Bill < ActiveRecord::Base
  belongs_to :category
  has_many :reminders
end
