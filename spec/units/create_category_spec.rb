require 'rails_helper'

describe Category do

	it "is named FPL" do
		category = Category.new
		category.name = "FPL"
		category.save
		expect(category.name).to eq("FPL")
		expect(Category.count).to eq(1)
	end

end