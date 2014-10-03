require 'rails_helper'

describe 'permissions' do

  before :each do
      User.create(first_name: "Joel", last_name: "Lusky", cell_phone: 1234567890, email: "joel@gmail.com", password: "12345678", password_confirmation: "12345678")
  end


  it "should redirect to dashboard and deny access if user trys to access providers" do
    visit "/"
    expect(page).to have_content('Forgot your password?')
    find(:css, "input[id$='user_email']").set("joel@gmail.com")
    find(:css, "input[id$='user_password']").set("12345678")
    click_button("Sign in")
    expect(page).to have_content("Hello")
    visit "/providers"
    expect(page).to have_content("You dont have access to the provider page.")
  end

  it "should redirect to dashboard and deny access if user trys to access categories" do
    visit "/"
    expect(page).to have_content('Forgot your password?')
    find(:css, "input[id$='user_email']").set("joel@gmail.com")
    find(:css, "input[id$='user_password']").set("12345678")
    click_button("Sign in")
    expect(page).to have_content("Hello")
    visit "/categories"
    expect(page).to have_content("You dont have access to the category page")
  end
end



