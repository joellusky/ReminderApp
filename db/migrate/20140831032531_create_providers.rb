class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.references :category, index: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
