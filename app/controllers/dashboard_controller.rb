class DashboardController < ApplicationController

	before_filter :authenticate_user!
 
	   
	def index
		@bills = current_user.bills.due_this_week
		if @bills.empty?
			@current_bills = nil
		else
			@current_bills = true
		end
	end

	
end
