class DeleteWorker

include Sidekiq::Worker
sidekiq_options retry: false


@@token = "00fd8690272c3a53aa4ae8527b68b18d"

  def perform(bill_id)
    bill = Bill.find(bill_id)

    response = HTTParty.get("http://localhost:8080/event_recurrences.json")
    # a is an array of hashes. each hash being an event recurrence. 
    a = JSON.parse(response.body)
    # a.each iterates over every hash in the response array.
    a.each do |hash|
    # if the hash has a key 'bill_id' whos value is equal to that of bill.id
    if hash['object_id'] == bill.id.to_s
    # @match represents the hash of the event recurrence that needs to be deleted on reminderService, when a bill is deleted in ReminderApp
    @match = hash
      end
    end
  

    #initiaes a delete request and interpolates the value of key[ID], and does converts it to integer.
    HTTParty.delete("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'object_id' => bill.id }.to_json, 

    :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )
  end
  
end