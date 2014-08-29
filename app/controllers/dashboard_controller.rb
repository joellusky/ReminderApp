class DashboardController < ApplicationController

	before_filter :authenticate_user!
 
	def index    
		@bills = Bill.all
	end
	
end
