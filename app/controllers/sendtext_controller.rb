class SendtextController < ApplicationController
  def index
  end

  def send_text_message
    number_to_send_to = current_user.cell_phone
 
    twilio_sid = "AC458c66afe8c3be7f362e34e212c63b84"
    twilio_token = "65796c1331a3c329820dd1f22033946e"
    twilio_phone_number = "(954)-933-5130"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "This is a reminder that your #{}"
    )
  end



  # if (reminder.alert == Time.now) && (reminder.user_id == user.id) 



end
