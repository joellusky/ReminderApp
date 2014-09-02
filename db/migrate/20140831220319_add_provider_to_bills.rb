class AddProviderToBills < ActiveRecord::Migration
  def change
    add_reference :bills, :provider, index: true
  end
end
