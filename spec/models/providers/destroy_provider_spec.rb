require 'rails_helper'

describe Provider do

	it "should destroy a provider succesfully" do
		provider = Provider.new
		provider.category_id = 2
		provider.name = "FPL"
		provider.url = "http://www.fpl.com"
		provider.save
		expect(Provider.count).to eq(1)
		provider.destroy
		expect(Provider.count).to eq(0)
	end

end