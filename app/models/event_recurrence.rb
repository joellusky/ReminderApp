class EventRecurrence < ActiveRecord::Base

  belongs_to :bill


	def dates(options={})
	    options = {:every => every, :starts => start_date, :until => end_date, :interval => interval || 1}.merge(options)
	    
	    options[:on] = 
		    case options[:every]
				when 'day','month'
					options[:starts].day
        when 'twice a year'
          options[:starts].day
		    when 'year'
				  [options[:starts].month, options[:starts].day]
		    when 'week', 'every two weeks'
		      	options[:starts].strftime('%A').downcase.to_sym
		    end

      options[:every] = 
      case options[:every]
      when 'every two weeks'
        'week'
      when 'twice a year'
        'month'
      when 'month'
        'month'
      when 'year'
        'year'
      end


      Recurrence.new(options).events
  	end
end
