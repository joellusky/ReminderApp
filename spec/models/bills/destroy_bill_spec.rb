require 'rails_helper'

describe Bill do 

	before :each do
      User.create(first_name: "Joel", last_name: "Lusky", cell_phone: 1234567890, email: "joel@gmail.com", password: "12345678", password_confirmation: "12345678")
      Category.create(name: "Electric")
      Provider.create(category_id: 1, name: "FPL", url: "http://www.fpl.com")
	end

	it 'should successfully delete bill instance from db' do
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
		bill.destroy
		expect(Bill.count).to eq(0)
	end

	it 'should delete recurrences along with its corresponding bill' do
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
		bill.destroy
		expect {
			Bill.find(bill.id)
		}.to raise_error(ActiveRecord::RecordNotFound)

		expect(EventRecurrence.where(bill: bill)).to be_empty
	end
end
