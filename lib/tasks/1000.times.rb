

task fake: :environment do
100.times do
	User.create(first_name: Faker::Name.first_name,
				last_name: Faker::Name.last_name,
				email: Faker::Internet.email,
				cell_phone: Faker::Number.number(10),
				password:  "password",
				terms: true)
	end
end