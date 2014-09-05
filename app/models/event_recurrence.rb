class EventRecurrence < ActiveRecord::Base

  belongs_to :bill

	def dates(options={})
	    options = {:every => every, :starts => start_date, :until => end_date}.merge(options)
	    options[:on] = case options[:every]
	    when 'year'
	      [options[:starts].month, options[:starts].day]
	    when 'week'
	      options[:starts].strftime('%A').downcase.to_sym
	    when 'day', 'month'
	      options[:starts].day
	    end
	    Recurrence.new(options).events
  	end
end
