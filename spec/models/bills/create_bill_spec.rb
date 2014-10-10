require 'rails_helper'

describe Bill do 

	 before :each do
      User.create(first_name: "Joel", last_name: "Lusky", cell_phone: 1234567890, email: "joel@gmail.com", password: "12345678", password_confirmation: "12345678")
      Category.create(name: "Electric")
      Provider.create(category_id: 1, name: "FPL", url: "http://www.fpl.com")
 	 end

	it 'should save when all fields are populated' do
		expect(User.count).to eq(1)
		expect(Category.count).to eq(1)
		expect(Provider.count).to eq(1)
		bill = Bill.new
		bill.user_id = User.last.id
		bill.provider_id = Provider.last.id
		bill.duedate = "2015-09-29"
		bill.every = "month"
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