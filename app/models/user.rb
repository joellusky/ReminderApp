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
end
