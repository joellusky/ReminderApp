class User < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
	has_many :bills, :dependent => :destroy

	validates :cell_phone, presence: true
	validates :cell_phone, length: { is: 10 }
	validates :cell_phone, :numericality => {:only_integer => true}
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :terms, presence: true

	geocoded_by :last_sign_in_ip
	after_validation :geocode


	

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
	:recoverable, :rememberable, :trackable, :validatable



	def ability
    @ability ||= Ability.new(self)
  	end

  	delegate :can?, :cannot?, :to => :ability

  	

	def self.from_omniauth(auth)
		where(auth.slice(:sprovider, :uid)).first_or_create do |user|
			user.sprovider = auth.provider
			user.uid = auth.uid
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name
			user.email = auth.info.email
			user.cell_phone = auth.info.cell_phone
  		end
	end

	def self.new_with_session(params, session)
		if session["devise.user_attributes"]
			new(session["devise.user_attributes"], without_protection: true) do |user|
				user.attributes = params
				user.valid?
			end
		else
			super
		end
	end



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

  	def password_required?
		if self.uid.nil?	
			super && true
		else
			false
		end
	end

	def update_with_password(params, *options)
		if encrypted_password.blank?
			update_attributes(params, *options)
		else
			super
		end
	end
end
