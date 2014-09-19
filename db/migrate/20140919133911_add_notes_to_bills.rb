class AddNotesToBills < ActiveRecord::Migration
  def change
    add_column :bills, :notes, :text
  end
end
