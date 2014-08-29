class users::confirmationsController < Devise::confirmationsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
