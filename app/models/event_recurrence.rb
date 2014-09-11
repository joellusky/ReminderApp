class EventRecurrence < ActiveRecord::Base

  belongs_to :bill


	def dates(options={})
	    options = {:every => every, :starts => start_date, :until => end_date, :interval => interval || 1}.merge(options)
	    
	    options[:on] = 
		    case options[:every]
				when 'day','month','every two weeks'
					[options[:starts].day]
          when 'twice a year'
            options[:starts].day
			    when 'year','twice a year'
					[options[:starts].month, options[:starts].day]
			    when 'week'
			      	options[:starts].strftime('%A').downcase.to_sym
		    end

      if options[:every] = 'every two weeks' and options[:interval] = 2
        options[:every] = 'week'
      end

      if options[:every] = 'twice a year' and options[:interval] = 6
        options[:every] = 'month'
      end
    
      Recurrence.new(options).events
  	end
end
