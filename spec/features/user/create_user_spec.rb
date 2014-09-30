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

describe "Signing in" do

	before :each do
	    User.create(first_name: "Alfonso", last_name: "Pintos", cell_phone: 7865467647, email: "Alfonsopintos@gmail.com", password: "12345678", password_confirmation: "12345678")
	end

	it "should redirect to dashboard upon succesful sign in" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonsopintos@gmail.com")
		find(:css, "input[id$='user_password']").set("12345678")
		click_button("Sign in")
		expect(page).to have_content("Hello")
	end

	it "should display error when incorrect email submission" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonso@gmail.com")
		find(:css, "input[id$='user_password']").set("12345678")
		click_button("Sign in")
		expect(page).to have_content("Forgot your password?")
	end

	it "should display error when incorrect password submission" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonsopintos@gmail.com")
		find(:css, "input[id$='user_password']").set("1234")
		click_button("Sign in")
		expect(page).to have_content("Forgot your password?")
	end

end

describe "User sign in" do 
	before :each do
	    User.create(first_name: "Alfonso", last_name: "Pintos", cell_phone: 7865467647, email: "Alfonsopintos@gmail.com", password: "12345678", password_confirmation: "12345678", admin: true)
	end

	it "should redirect to admin dashboard upon succesful sign in" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonsopintos@gmail.com")
		find(:css, "input[id$='user_password']").set("12345678")
		click_button("Sign in")
		expect(page).to have_content("Admin Dashboard")
	end

	it "should display error when incorrect email submission" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonso@gmail.com")
		find(:css, "input[id$='user_password']").set("12345678")
		click_button("Sign in")
		expect(page).to have_content("Forgot your password?")
	end

	it "should display error when incorrect password submission" do
		visit "/"
		expect(page).to have_content('Forgot your password?')
		find(:css, "input[id$='user_email']").set("alfonsopintos@gmail.com")
		find(:css, "input[id$='user_password']").set("1234")
		click_button("Sign in")
		expect(page).to have_content("Forgot your password?")
	end
	
end

