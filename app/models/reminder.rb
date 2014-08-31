class Reminder < ActiveRecord::Base
  belongs_to :bill
  belongs_to :user

  validates :bill, presence: true
end
