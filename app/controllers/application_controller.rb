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

	def send_text_message
		current_user.setup_twilio do |twilio|
			twilio.account.sms.messages.create(
				:from => "+1#{twilio_phone_number}",
				:to => number_to_send_to,
				:body => "You have just added your #{@bill.name} #{@bill.category.name} bill!")
		end
	end

	def phone_call_reminder
		current_user.setup_twilio do |twilio|
			twilio.account.calls.create(
				:from => twilio_phone_number,
				:to => number_to_send_to,
				:url => "http://twimlets.com/message?Message%5B0%5D=Hello!%20%20%20%20%20%20%20%20%20%20This%20is%20a%20reminder%20that%20your%20#{@bill.name} #{@bill.category.name}%20is%20due%20tomorrow!%20Good%20bye!&"
				)
		end
	end


end
