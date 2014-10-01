require 'rails_helper'

describe User do 

  it 'should save when all fields are populated' do
    user = User.new
    user.first_name = "Joel"
    user.last_name = "Lusky"
    user.cell_phone = 1234567890
    user.email = "joel@gmail.com"
    user.password = "12345678"
    user.password_confirmation = "12345678"
    user.save
    expect(User.count).to eq(1)
  end
end

