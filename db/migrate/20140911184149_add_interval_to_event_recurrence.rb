class AddIntervalToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :interval, :integer
  end
end
