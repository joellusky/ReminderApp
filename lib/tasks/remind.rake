namespace :remind do
  desc "TODO"
  task text: :environment do
  	tomorrow = Date.tomorrow
  	Bill.all.each do |bill|
  		bill.dates.each do |duedate|
  			puts bill, duedate
  			puts "Email this guy: #{bill.user.email}" if duedate == tomorrow
  			bill.user.get_twilio do |twilio|
  				p twilio
  			end if duedate == tomorrow
  		end
  	end
  end


  desc "TODO"
  task phone: :environment do
  	puts "Phone people"
  end

end
