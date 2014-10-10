class DeleteWorker

include Sidekiq::Worker
sidekiq_options retry: false


@@token = "d26f11c26ff5472f884e864f2d232f08"

  def perform(bill_id)
    # bill = Bill.find(bill_id)

    response = HTTParty.get("http://localhost:8080/event_recurrences.json")
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
    HTTParty.delete("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'object_id' => bill_id }.to_json, 

    :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )
  end
  
end