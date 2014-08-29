class DashboardController < ApplicationController

	before_filter :authenticate_user!
 
	   
	def index
		@bills = Bill.where(user_id: current_user.id, duedate: Date.current)
		if @bills.empty?
			@current_bills = nil
		else
			@current_bills = true
		end
	end

	
end
