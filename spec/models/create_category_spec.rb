require 'rails_helper'

describe Category do

	it "should have a name" do
		category = Category.new
		category.name = "FPL"
		category.save
		expect(category.name).to eq("FPL")
		expect(Category.count).to eq(1)
	end

	it "should not save when no name provided" do
		category = Category.new
		category.name = ""
		category.save
		expect(Category.count).to eq(0)
	end


end