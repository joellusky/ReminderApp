require 'rails_helper'

describe 'Signing up' do

	it "should redirect to dashboard upon succesful user sign up" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("12345678")
		click_button ('Sign up')
		expect(page).to have_content('You Have No Bills Due This Week')
	end

	it 'should not permit signup with first name left blank' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("12345678")
		click_button ('Sign up')
		expect(page).to have_no_content('You Have No Bills Due This Week')
	end

	it 'should not permit signup with last name left blank' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("12345678")
		click_button ('Sign up')
		expect(page).to have_no_content('You Have No Bills Due This Week')
	end

	it 'should raise error if phone number is not ten digits' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("12345678")
		click_button ('Sign up')
		expect(page).to have_content('Cell Phone is the wrong length')
	end

	it 'should raise error if email is not properly formatted' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("12345678")
		click_button ('Sign up')
		expect(page).to have_no_content('You Have No Bills Due This Week')
	end

	it 'should raise error if password is not 8 characters' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345")
		find(:css, "input[id$='user_password_confirmation']").set("12345")
		click_button ('Sign up')
		expect(page).to have_no_content('You Have No Bills Due This Week')
	end

	it 'should not permit signup if password and password confirmation do not match' do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		click_on("Sign up")
		find(:css, "input[id$='user_first_name']").set("Joel")
		find(:css, "input[id$='user_last_name']").set("Lusky")
		find(:css, "input[id$='user_cell_phone']").set("1234567890")
		find(:css, "input[id$='user_email']").set("joel@gmail.com")
		find(:css, "input[id$='myPassword']").set("12345678")
		find(:css, "input[id$='user_password_confirmation']").set("abcdefghijk")
		click_button ('Sign up')
		expect(page).to have_no_content('You Have No Bills Due This Week')
	end
end

