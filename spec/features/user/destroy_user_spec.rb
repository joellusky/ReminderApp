require 'rails_helper'

describe 'deleting a user' do

  before :each do
      User.create(first_name: "Joel", last_name: "Lusky", cell_phone: 1234567890, email: "joel@gmail.com", password: "12345678", password_confirmation: "12345678")
  end


  it "should successfully delete a user" do
    visit "/"
    expect(page).to have_content('Forgot your password?')
    find(:css, "input[id$='user_email']").set("joel@gmail.com")
    find(:css, "input[id$='user_password']").set("12345678")
    click_button("Sign in")
    expect(page).to have_content("Hello")
    visit "/users/edit"
    click_button("Cancel my account")
    
    # javascript alert defaults to true, therefore you dont have to click_button("Ok")
    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
  end
end



