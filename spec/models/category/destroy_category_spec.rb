require 'rails_helper'

describe Category do

	it "should succesfully destroy a category" do
		category = Category.new
		category.name = "Electric"
		category.save
		expect(Category.count).to eq(1)
		Category.destroy_all
		expect(Category.count).to eq(0)
	end

end