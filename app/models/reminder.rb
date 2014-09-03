class Reminder < ActiveRecord::Base
  belongs_to :bill

	def reminder_check
		 if @reminders = Reminder.where(alert: Time.current)
		  		send_text_message
		end
	end

end
