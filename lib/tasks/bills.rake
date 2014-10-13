
def every_choice
  ["every two weeks", "twice a year", "month", "year"].sample
end

def contact_choice
  ["text", "phone call", "email"].sample
end

def provider_choice
  [1,2,3,4,5,6,7,8,9,10].sample
end


task :bills => :environment do 

  users = User.all
  users.each do |user|

    5.times do 
      Bill.create(
      user_id: user.id,
      duedate: Time.now.strftime("%Y-%m-%d"),
      every: every_choice,
      contact_method: contact_choice,
      provider_id: provider_choice)
    end
  end
end