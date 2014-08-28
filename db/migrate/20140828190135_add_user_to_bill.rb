class AddUserToBill < ActiveRecord::Migration
  def change
    add_reference :bills, :user, index: true
  end
end
