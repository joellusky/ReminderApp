class DashboardController < ApplicationController

	before_filter :authenticate_user!
 
	   
	def index
		@bills = current_user.bills.due_this_week
	end

	
end
