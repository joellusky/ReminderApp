class CreateEventRecurrences < ActiveRecord::Migration
  def change
    create_table :event_recurrences do |t|
      t.references :bill, index: true

      t.timestamps
    end
  end
end
