class AddContactMethodToBill < ActiveRecord::Migration
  def change
    add_column :bills, :contact_method, :string
  end
end
