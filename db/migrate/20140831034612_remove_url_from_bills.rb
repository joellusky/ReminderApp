class RemoveUrlFromBills < ActiveRecord::Migration
  def change
    remove_column :bills, :url, :delete
  end
end
