class User < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
	has_many :bills

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	def bill_occurences
		# for each bill
		self.bills.map { |bill|
			# for each date, create an array of
			bill.dates.map { |date|
				# bill occurences (a date at a point in time)
				bill_occurrence = bill.clone
				bill_occurrence.date = date
				bill_occurrence
			}
		}.flatten
	end

	def get_twilio
		number_to_send_to = self.cell_phone
		account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
		auth_token = "65796c1331a3c329820dd1f22033946e"
		twilio_phone_number = "(954)-933-5130"

		yield Twilio::REST::Client.new account_sid, auth_token
	end
end
