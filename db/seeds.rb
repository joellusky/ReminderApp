# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [
	"Water",
	"Electric",
	"Mortgage / Rent",
	"Credit Card",
	"Cell Phone",
	"Insurance",
	"Car Payment",
	"Internet / TV",
	].map do |cat|
		Category.find_or_create_by name: cat
	end.inject({}) { |mem, var| mem[var.name] = var; mem }
	
Provider.find_or_create_by(name: "FPL").update_attributes(category: categories["Electric"], url: "https://app.fpl.com/eca/EcaController")
Provider.find_or_create_by(name: "Miami-Dade-County").update_attributes(category: categories["Water"], url: "http://www.miamidade.gov/water/pay-bill.asp")
Provider.find_or_create_by(name: "Verizon").update_attributes(category: categories["Cell Phone"], url: "https://www.verizon.com/foryourhome/MyAccount/ngen/upr/nlogin.aspx")
Provider.find_or_create_by(name: "AT&T").update_attributes(category: categories["Cell Phone"], url: "https://www.att.com/olam/loginAction.olamexecute")
Provider.find_or_create_by(name: "Sprint").update_attributes(category: categories["Cell Phone"], url: "https://mysprint.sprint.com/mysprint/pages/sl/global/login.jsp?targetPage=https%253A%252F%252Fmysprint.sprint.com%252Fmysprint%252Fpages%252Fsecure%252Fmyaccount%252FlandingPage.jsp")
Provider.find_or_create_by(name: "Metro PCS").update_attributes(category: categories["Cell Phone"], url: "https://www.metropcs.com/bill-pay.html")
Provider.find_or_create_by(name: "Boost Mobile").update_attributes(category: categories["Cell Phone"], url: "https://www.boostmobile.com")
Provider.find_or_create_by(name: "Cricket").update_attributes(category: categories["Cell Phone"], url: "https://www.cricketwireless.com/my-account.html")
Provider.find_or_create_by(name: "T-Mobile").update_attributes(category: categories["Cell Phone"], url: "https://my.t-mobile.com/Login/?rc=&dest=https%3a%2f%2fmy.t-mobile.com%3a443%2fbilling%2fonetimepaysignup.aspx")
Provider.find_or_create_by(name: "Virgin Mobile").update_attributes(category: categories["Cell Phone"], url: "https://www2.virginmobileusa.com/myaccount/home.do")
Provider.find_or_create_by(name: "American Express").update_attributes(category: categories["Credit Card"], url: "https://www.americanexpress.com/")

Provider.find_or_create_by(name: "Discover").update_attributes(category: categories["Credit Card"], url: "http://www.discovercard.com")



Provider.find_or_create_by(name: "Discover").update_attributes(category: categories["Credit Card"], url: "http://www.discovercard.com")
Provider.find_or_create_by(name: "Geico").update_attributes(category: categories["Insurance"], url: "http://www.geico.com")
Provider.find_or_create_by(name: "Progressive").update_attributes(category: categories["Insurance"], url: "http:www.progressive.com")
Provider.find_or_create_by(name: "Comcast").update_attributes(category: categories["Internet / TV"], url: "http://www.comcast.com")
Provider.find_or_create_by(name: "HotWire Communications").update_attributes(category: categories["Internet / TV"], url: "http://gethotwired.com/my-account/first-visit")
Provider.find_or_create_by(name: "Rent Payment").update_attributes(category: categories["Mortgage / Rent"], url: "http://www.rentpayment.com/")
Provider.find_or_create_by(name: "Ford").update_attributes(category: categories["Car Payment"], url: "https://credit.ford.com/how-to-pay")