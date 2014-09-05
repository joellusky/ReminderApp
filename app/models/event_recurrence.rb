class EventRecurrence < ActiveRecord::Base
# app/models/event_recurrence.rb
# It has :start_date, :every and :end_date as database columns 
  
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
end
