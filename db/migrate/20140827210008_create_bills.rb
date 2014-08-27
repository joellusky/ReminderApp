class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.references :category, index: true
      t.string :url
      t.date :duedate

      t.timestamps
    end
  end
end
