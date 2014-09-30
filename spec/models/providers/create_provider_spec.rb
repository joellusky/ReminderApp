require 'rails_helper'

describe Provider do

	it "should not save when no category_id provided" do
		provider = Provider.new
		provider.category_id = nil
		provider.save
		expect(Provider.count).to eq(0)
	end

	it "should not save when no name provided" do
		provider = Provider.new
		provider.name = nil
		provider.save
		expect(Provider.count).to eq(0)
	end

	it "should not save when no name provided" do
		provider = Provider.new
		provider.url = nil
		provider.save
		expect(Provider.count).to eq(0)
	end

	it "should save succesfully with correct information" do
		provider = Provider.new
		provider.category_id = 1
		provider.name = "FPL"
		provider.url = "http://www.fpl.com"
		provider.save
		expect(Provider.count).to eq(1)
		expect(provider.category_id).to eq(1)
		expect(provider.name).to eq("FPL")
		expect(provider.url).to eq("http://www.fpl.com")
	end


end