
def sprovider
	["devise", "facebook"].sample
end

def country_choice
	["United States", "Canada", "Puerto Rico", "Uruguay"].sample
end

def every_choice
	["every two weeks", "twice a year", "month", "year"].sample
end

def contact_choice
	["text", "phone call", "both"].sample
end

def provider_choice
	[1,2,3,4,5,6,7,8,9,10].sample
end



task :fake => :environment do

20.times do
	user = User.create(first_name: Faker::Name.first_name,
				last_name: Faker::Name.last_name,
				email: Faker::Internet.email,
				cell_phone: Faker::Number.number(10),
				password:  "password",
				country: country_choice,
				sprovider: sprovider)

	Bill.create(user: user,
				duedate: Time.now.strftime("%Y-%m-%d"),
				every: every_choice,
				contact_method: contact_choice,
				provider_id: provider_choice)
	end
end


task :admin => :environment do
	1.times do
user = User.create(first_name: "Joel",
				last_name: "Lusky",
				email: "joelzlusky@gmail.com",
				cell_phone: "3057615259",
				password:  "12345678",
				terms: true,
				country: "United States",
				sprovider: "devise",
				admin: true)
	end
end














