class RemoveUserFromReminder < ActiveRecord::Migration
  def change
    remove_reference :reminders, :user, index: true
  end
end
