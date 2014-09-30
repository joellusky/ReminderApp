class RemoveTermsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :terms, :boolean
  end
end
