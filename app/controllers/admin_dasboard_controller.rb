class AdminDasboardController < ApplicationController
	before_action :set_twilio

  def index

  	 	@bills = Bill.search(params[:search])

  	 	# Loop over records and print out a property for each one
		@client.account.usage.records.last_month.list.each do |record|
	    puts record.count
		end
  end




  private

  	def set_twilio
	  # Get your Account Sid and Auth Token from twilio.com/user/account
		account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
		auth_token = "65796c1331a3c329820dd1f22033946e"
		@client = Twilio::REST::Client.new account_sid, auth_token
	end

end
