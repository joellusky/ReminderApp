require 'rails_helper'

describe Bill do 
	it 'should not save when duedate is blank' do
		bill = Bill.new
		bill.duedate = ""
		bill.save
		expect(Bill.count).to eq(0)
	end
end