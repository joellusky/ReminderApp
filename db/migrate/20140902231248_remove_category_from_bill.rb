class RemoveCategoryFromBill < ActiveRecord::Migration
  def change
    remove_column :bills, :category_id, :int
  end
end
