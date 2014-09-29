
def sprovider
	["devise", "facebook"].sample
end

task :fake => :environment do

1.times do
	User.create(first_name: Faker::Name.first_name,
				last_name: Faker::Name.last_name,
				email: Faker::Internet.email,
				cell_phone: Faker::Number.number(10),
				password:  "password",
				terms: true,
				country: Faker::Address.country,
				sprovider: sprovider)
	end
end