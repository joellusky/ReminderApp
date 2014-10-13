class DeleteJob

include SuckerPunch::Job
# include Sidekiq::Worker
# sidekiq_options retry: false


@@token = "11bbad9f27d1494f8d8570db1ba4855a"

  def perform(bill_id)
    # bill = Bill.find(bill_id)

    response = HTTParty.get("http://sleepy-citadel-7753.herokuapp.com/event_recurrences.json")
    # a is an array of hashes. each hash being an event recurrence. 
    a = JSON.parse(response.body)
    # a.each iterates over every hash in the response array.
      a.each do |hash|
    # if the hash has a key 'object_id' whos value is equal to that of bill.id
        if hash['object_id'] == bill_id.to_s
    # @match represents the instance on the API that needs to be deleted, when a bill is deleted in ReminderApp
          @match = hash
        end
      end
  

    #Does the delete by inputting the instance ID of the object we are attempting to delete
    HTTParty.delete("http://sleepy-citadel-7753.herokuapp.com/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'object_id' => bill_id }.to_json, 

    :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )
  end
  
end