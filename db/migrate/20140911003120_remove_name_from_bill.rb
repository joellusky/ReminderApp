class RemoveNameFromBill < ActiveRecord::Migration
  def change
    remove_column :bills, :name, :string
  end
end
