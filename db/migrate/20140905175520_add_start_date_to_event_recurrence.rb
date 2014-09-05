class AddStartDateToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :start_date, :datetime
    add_column :event_recurrences, :every, :string
    add_column :event_recurrences, :end_date, :datetime
  end
end
