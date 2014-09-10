namespace :remind do
  desc "TODO"
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
  	puts "Phone people"
  end

end
