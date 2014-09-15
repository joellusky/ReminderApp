class AddTermsToBill < ActiveRecord::Migration
  def change
    add_column :bills, :terms, :boolean, :default => false
  end
end
