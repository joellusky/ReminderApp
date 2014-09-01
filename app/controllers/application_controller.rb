class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resources)
		dashboard_index_path
	end


	protected

	def configure_permitted_parameters
		puts "configure_permitted_parameters"
		[:sign_up, :account_update].each do |action|
			devise_parameter_sanitizer.for(action).push(:first_name, :last_name, :cell_phone)
		end
	end

end
