class User < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
	has_many :bills

	validates :cell_phone, presence: true
	validates :cell_phone, length: { is: 10 }
	validates :first_name, presence: true
	validates :last_name, presence: true


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
		account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
		auth_token = "65796c1331a3c329820dd1f22033946e"

		number_to_send_to = self.cell_phone
		twilio_phone_number = "(954)-933-5130"

		client = Twilio::REST::Client.new account_sid, auth_token

		yield(client, twilio_phone_number, number_to_send_to)
	end

	def bills_due_this_week
	    all_week = Date.current.all_week.to_a
	    bills.select { |bill| 
	      (bill.dates & all_week).any?
	    }
  	end

  	def bills_due_last_week
	    last_week = Date.current.last_week.all_week.to_a
	    bills.select { |bill| 	
	    	if !bill.paid
	    		(bill.dates & last_week).any?
	    	end
	    }
  	end
  


end
