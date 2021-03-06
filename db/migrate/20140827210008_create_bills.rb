class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :category, index: true
      t.string :url
      t.date :duedate
      t.boolean :paid

      t.timestamps
    end
  end
end
