class DashboardController < ApplicationController

	before_filter :authenticate_user!
 
	   
	def index
		@bills = current_user.bills_due_this_week
		@bills_past = current_user.bills_due_last_week
	end

	
end
