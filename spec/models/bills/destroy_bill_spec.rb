require 'rails_helper'

describe Bill do 

	before :each do
	    Bill.create(user_id: 1, duedate: Date.today + 1.day, every: "month", provider_id: 1, contact_method: "text")
	end

	it 'should successfully delete bill instance from db' do
		bill = Bill.take
		expect(Bill.count).to eq(1)
		bill.destroy
		expect(Bill.count).to eq(0)
	end

	it 'should delete recurrences along with its corresponding bill' do
		bill = Bill.take
		expect(Bill.count).to eq(1)
		expect(bill.dates.count).to eq(13)
		bill.destroy
		expect {
			Bill.find(bill.id)
		}.to raise_error(ActiveRecord::RecordNotFound)

		expect(EventRecurrence.where(bill: bill)).to be_empty
	end
end
