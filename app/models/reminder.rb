class Reminder < ActiveRecord::Base
  belongs_to :bill

  #validates :bill, presence: true
end
