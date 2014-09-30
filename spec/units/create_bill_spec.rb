require 'rails_helper'

describe Bill do 

	it 'should save when all fields are populated' do
		bill = Bill.new
		bill.user_id = "1"
		bill.duedate = "2015-09-29"
		bill.every = "month"
		bill.provider_id = "1"
		bill.contact_method = "text"
		bill.save
		expect(Bill.count).to eq(1)
	end

	it 'should not save when duedate is blank' do
		bill = Bill.new
		bill.duedate = ""
		bill.save
		expect(Bill.count).to eq(0)
	end

	it 'should not save when recurrence is blank' do
		bill = Bill.new
		bill.every = ""
		bill.save
		expect(Bill.count).to eq(0)
	end

	it 'should not save when provider_id is blank' do
		bill = Bill.new
		bill.provider_id = ""
		bill.save
		expect(Bill.count).to eq(0)
	end

	it 'should not save when user_id is blank' do
		bill = Bill.new
		bill.user_id = ""
		bill.save
		expect(Bill.count).to eq(0)
	end

	it 'should not save when contact method is blank' do
		bill = Bill.new
		bill.contact_method = ""
		bill.save
		expect(Bill.count).to eq(0)
	end
end