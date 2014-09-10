class Users::RegistrationsController < Devise::registrationsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :cell_phone)
  end
 
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :cell_phone)
  end

end
