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


Provider.find_or_create_by(name: "Miami-Dade-County").update_attributes(category: categories["Water"], url: "http://www.miamidade.gov/water/pay-bill.asp")	
Provider.find_or_create_by(name: "FPL").update_attributes(category: categories["Electric"], url: "https://app.fpl.com/eca/EcaController")

Provider.find_or_create_by(name: "AT&T").update_attributes(category: categories["Cell Phone"], url: "https://www.att.com/olam/loginAction.olamexecute")
Provider.find_or_create_by(name: "Boost Mobile").update_attributes(category: categories["Cell Phone"], url: "https://www.boostmobile.com")
Provider.find_or_create_by(name: "Cricket").update_attributes(category: categories["Cell Phone"], url: "https://www.cricketwireless.com/my-account.html")
Provider.find_or_create_by(name: "Metro PCS").update_attributes(category: categories["Cell Phone"], url: "https://www.metropcs.com/bill-pay.html")
Provider.find_or_create_by(name: "Sprint").update_attributes(category: categories["Cell Phone"], url: "http://www.sprint.com/mysprint/pages/sl/global/login.jsp?context=CC&INTNAV=TSC:IHP:ExpWC:SignIn:053014")
Provider.find_or_create_by(name: "T-Mobile").update_attributes(category: categories["Cell Phone"], url: "https://my.t-mobile.com/Login/?rc=&dest=https%3a%2f%2fmy.t-mobile.com%3a443%2fbilling%2fonetimepaysignup.aspx")
Provider.find_or_create_by(name: "Verizon").update_attributes(category: categories["Cell Phone"], url: "https://www.verizon.com/foryourhome/MyAccount/ngen/upr/nlogin.aspx")
Provider.find_or_create_by(name: "Virgin Mobile").update_attributes(category: categories["Cell Phone"], url: "https://www2.virginmobileusa.com/myaccount/home.do")



Provider.find_or_create_by(name: "American Express").update_attributes(category: categories["Credit Card"], url: "https://www.americanexpress.com/")
Provider.find_or_create_by(name: "Discover").update_attributes(category: categories["Credit Card"], url: "http://www.discovercard.com")
Provider.find_or_create_by(name: "Visa").update_attributes(category: categories["Credit Card"], url: "http://www.discovercard.com")
Provider.find_or_create_by(name: "Discover").update_attributes(category: categories["Credit Card"], url: "http://www.discovercard.com")


Provider.find_or_create_by(name: "21st Century").update_attributes(category: categories["Insurance"], url: "www.21st.com/esauth/QuickPayLanding.do?method=initPaymentLogin")
Provider.find_or_create_by(name: "Allstate").update_attributes(category: categories["Insurance"], url: "http://www.allstate.com/support/payment-and-billing.aspx")
Provider.find_or_create_by(name: "Estrella").update_attributes(category: categories["Insurance"], url: "http://www.estrellainsurance.com/Make-A-Payment-United-Auto")
Provider.find_or_create_by(name: "Farmers").update_attributes(category: categories["Insurance"], url: "http://www.farmers.com/payments/")
Provider.find_or_create_by(name: "Geico").update_attributes(category: categories["Insurance"], url: "http://www.geico.com")
Provider.find_or_create_by(name: "Liberty Mutual").update_attributes(category: categories["Insurance"], url: "http://www.libertymutual.com/customer-service/billing")
Provider.find_or_create_by(name: "MetLife").update_attributes(category: categories["Insurance"], url: "www.metlife.com/about/corporate-profile/pay-a-bill/index.html")
Provider.find_or_create_by(name: "Progressive").update_attributes(category: categories["Insurance"], url: "http:www.progressive.com")
Provider.find_or_create_by(name: "State Farm").update_attributes(category: categories["Insurance"], url: "www.statefarm.com/finances/banking/online-banking-demo/bill-pay")



Provider.find_or_create_by(name: "Atlantic Broadband").update_attributes(category: categories["Internet / TV"], url: "atlanticbb.com/support/account")
Provider.find_or_create_by(name: "AT&T").update_attributes(category: categories["Internet / TV"], url: "www.att.com/olam/loginAction.olamexecute")
Provider.find_or_create_by(name: "Comcast").update_attributes(category: categories["Internet / TV"], url: "www.comcast.com")
Provider.find_or_create_by(name: "DIRECTV").update_attributes(category: categories["Internet / TV"], url: "www.directv.com/DTVAPP/login/login.jsp")
Provider.find_or_create_by(name: "Dish").update_attributes(category: categories["Internet / TV"], url: "my.dish.com/customercare/paymybill/populateBillingDetails.do")
Provider.find_or_create_by(name: "HotWire Communications").update_attributes(category: categories["Internet / TV"], url: "gethotwired.com/my-account/first-visit")


Provider.find_or_create_by(name: "Rent Payment").update_attributes(category: categories["Mortgage / Rent"], url: "www.rentpayment.com/")



Provider.find_or_create_by(name: "Acura").update_attributes(category: categories["Car Payment"], url: "www.acurafinancialservices.com/account-management/payment-options")
Provider.find_or_create_by(name: "Audi").update_attributes(category: categories["Car Payment"], url: "www.audiusa.com/help/account-management")
Provider.find_or_create_by(name: "BMW").update_attributes(category: categories["Car Payment"], url: "www.bmwusa.com/secured/content/forms/login.aspx")
Provider.find_or_create_by(name: "Chevrolet").update_attributes(category: categories["Car Payment"], url: "my.chevrolet.com/web/portal/managemybrand?g=1")
Provider.find_or_create_by(name: "Chrysler").update_attributes(category: categories["Car Payment"], url: "chryslercapital.com/customers/make-a-payment")
Provider.find_or_create_by(name: "Dodge").update_attributes(category: categories["Car Payment"], url: "chryslercapital.com/customers/make-a-payment")
Provider.find_or_create_by(name: "Ford").update_attributes(category: categories["Car Payment"], url: "credit.ford.com/how-to-pay")
Provider.find_or_create_by(name: "GMC").update_attributes(category: categories["Car Payment"], url: "www.gmfinancial.com/myaccount/PaymentOptions.aspx")
Provider.find_or_create_by(name: "Honda").update_attributes(category: categories["Car Payment"], url: "www.hondafinancialservices.com/account-management/payment-options")
Provider.find_or_create_by(name: "Hyundai").update_attributes(category: categories["Car Payment"], url: "www.hmfusa.com/login")
Provider.find_or_create_by(name: "Infiniti").update_attributes(category: categories["Car Payment"], url: "www.infinitifinance.com/nmaccss/")
Provider.find_or_create_by(name: "Jaguar").update_attributes(category: categories["Car Payment"], url: "www.jaguarcredit.com/auto_payment/index.jhtml")
Provider.find_or_create_by(name: "Jeep").update_attributes(category: categories["Car Payment"], url: "chryslercapital.com/customers/make-a-payment")
Provider.find_or_create_by(name: "Land Rover").update_attributes(category: categories["Car Payment"], url: "www.chase.com/business-banking/dealer-services/land-rover-financial-group")
Provider.find_or_create_by(name: "Lexus").update_attributes(category: categories["Car Payment"], url: "www.lexusfinancial.com/pub/home/")
Provider.find_or_create_by(name: "Lincoln").update_attributes(category: categories["Car Payment"], url: "credit.lincoln.com/how-to-pay")
Provider.find_or_create_by(name: "Mazda").update_attributes(category: categories["Car Payment"], url: "www.chase.com/business-banking/dealer-services/mazda-capital-services")
Provider.find_or_create_by(name: "Mercedes Benz").update_attributes(category: categories["Car Payment"], url: "www.mbfs.com/mbfsr/en/misc/index.do")
Provider.find_or_create_by(name: "Mini").update_attributes(category: categories["Car Payment"], url: "ol.miniusa.com")
Provider.find_or_create_by(name: "Mitsubishi").update_attributes(category: categories["Car Payment"], url: "mitsubishicredit.com/sb.cn")
Provider.find_or_create_by(name: "Nissan").update_attributes(category: categories["Car Payment"], url: "paymentsnmac.billmatrix.com/welcome.aspx")
Provider.find_or_create_by(name: "Porsche").update_attributes(category: categories["Car Payment"], url: "http://www.porsche.com/usa/accessoriesandservices/porschefinancialservices/")
Provider.find_or_create_by(name: "Scion").update_attributes(category: categories["Car Payment"], url: "www.toyotafinancial.com/pub/home/")
Provider.find_or_create_by(name: "Subaru").update_attributes(category: categories["Car Payment"], url: "www.chase.com/business-banking/dealer-services/subaru-motors-finance")
Provider.find_or_create_by(name: "Suzuki").update_attributes(category: categories["Car Payment"], url: "www.ally.com/auto/online-services/access/pre-login.html")
Provider.find_or_create_by(name: "Toyota").update_attributes(category: categories["Car Payment"], url: "m.toyotafinancial.com/pub/payby/paymentoption.htm")
Provider.find_or_create_by(name: "Volkswagen").update_attributes(category: categories["Car Payment"], url: "http://www.vw.com/financial-services/")
Provider.find_or_create_by(name: "Volvo").update_attributes(category: categories["Car Payment"], url: "www.volvocarfinancialservices.com/sb.cn")




