class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :notes
      t.datetime :alert
      t.references :bill, index: true

      t.timestamps
    end
  end
end
