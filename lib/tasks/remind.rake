namespace :remind do
  desc "Looks through all bills and finds bills due tomorrow sends user text reminder"

  task text: :environment do
  	tomorrow = Date.tomorrow
  	Bill.all.each do |bill|
  		bill.dates.each do |duedate|
  			if duedate == tomorrow
          bill.user.get_twilio do |twilio, number_from, number_to|
            twilio.account.sms.messages.create(
              :from => number_from,
              :to => number_to,
              :body => "Hello #{bill.user.first_name}! This is a friendly reminder that your #{bill.provider.name}, #{bill.category.name} bill is due tomorrow.")
          end
        end 
      end
    end
  end


  desc "TODO"
  task phone: :environment do
    tomorrow = Date.tomorrow
    Bill.all.each do |bill|
      bill.dates.each do |duedate|
        if duedate == tomorrow
          message = "Hello #{bill.user.first_name}! This is a friendly reminder that your #{bill.provider.name}, #{bill.category.name} bill is due tomorrow."
         bill.user.get_twilio do |twilio, number_from, number_to|
           url = "http://twimlets.com/voicemail?Message=#{URI::encode message}"
           twilio.account.calls.create(
            :from => number_from,
            :to => number_to,
            :url => url
            )
         end
       end
     end
   end
 end
end
