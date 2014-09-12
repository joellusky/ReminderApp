class AddIntervalToBill < ActiveRecord::Migration
  def change
    add_column :bills, :interval, :string
  end
end
