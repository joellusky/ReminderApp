class UsersController < ApplicationController

	def destroy
	  User.find(params[:id]).destroy
	  flash[:success] = "User destroyed."
	  redirect_to admin_dashboard_all_users_path
	end

# def user_params
#       params.require(:user).permit(:country)
# end
end

