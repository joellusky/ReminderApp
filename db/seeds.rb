# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	categories = Category.create([
		{name: "Water"},
		{name: "Electric"},
		{name: "Mortgage/Rent"},
		{name: "Creditcard"},
		{name: "Cellphone"},
		{name: "Insurance"},
		{name: "Car Payment"},
		{name: "Internet/TV"}
		])

	# providers =Provider.create([
	# 	{name: "",
	# 	 category_id: 1},
	# 	{name: "",
	# 	 category_id: 1}
	# 	])