class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :bill
end
