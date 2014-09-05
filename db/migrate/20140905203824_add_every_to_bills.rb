class AddEveryToBills < ActiveRecord::Migration
  def change
    add_column :bills, :every, :string
  end
end
