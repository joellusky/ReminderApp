class Reminder < ActiveRecord::Base
  belongs_to :bill

  	# def time_format
  	# 	Time.now.to_s.split(" ").delete_at[2].join(" ")
  	# end
end
