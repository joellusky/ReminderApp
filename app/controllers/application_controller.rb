class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.

	rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  	end


	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resources)
		dashboard_index_path
	end


	protected

	def configure_permitted_parameters
		puts "configure_permitted_parameters"
		[:sign_up, :account_update].each do |action|
			devise_parameter_sanitizer.for(action).push(:first_name, :last_name, :cell_phone, :terms)
		end
	end

	def send_text_message
		current_user.get_twilio do |twilio, number_from, number_to|
			twilio.account.sms.messages.create(
				:from => number_from,
				:to => number_to,
				:body => "You have just added your #{@bill.provider.name} #{@bill.category.name} Bill!")
		end
	end

	def phone_call_reminder
		url = "http://twimlets.com/voicemail?Message=Hello%2C%20%20%20%20%20%20%20this%20is%20a%20reminder%20that%20you%20have%20a%20bill%20due%20tomorrow.%20Good%20Bye.&"
		
		current_user.get_twilio do |twilio, number_from, number_to|
			twilio.account.calls.create(
				:from => number_from,
				:to => number_to,
				:url => URI::encode(url)
				)
		end
	end


end
