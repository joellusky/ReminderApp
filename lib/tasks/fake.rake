
def sprovider
	["devise", "facebook"].sample
end

def country_choice
	["United States", "Canada", "Puerto Rico", "Uruguay"].sample
end




task :fake => :environment do

	5.times do user = User.create(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.email,
		cell_phone: Faker::Number.number(10),
		password:  "password",
		country: country_choice,
		sprovider: sprovider)
	end
end











