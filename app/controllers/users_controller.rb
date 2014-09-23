class UsersController < ApplicationController

	def destroy
	  User.find(params[:id]).destroy
	  flash[:success] = "User destroyed."
	  redirect_to admin_dashboard_all_users_path
	end
end

