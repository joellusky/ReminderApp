class UpdateWorker

include Sidekiq::Worker
sidekiq_options retry: false


  @@token = "00fd8690272c3a53aa4ae8527b68b18d"

  def perform(bill_id)
    bill = Bill.find(bill_id)

     response = HTTParty.get("http://localhost:8080/event_recurrences.json")
    a = JSON.parse(response.body)
    a.each do |hash|
      if hash['object_id'] == bill.id.to_s
        @match = hash
      end
    end
    
    HTTParty.patch("http://localhost:8080/event_recurrences/#{@match['id'].to_i}.json", 
    :body => {'object_id' => bill.id,
    'end_date' => bill.duedate + 1.year,
    'every' => bill.every,
    'start_date' => bill.duedate, 
    'cell_phone' => bill.user.cell_phone,
    'email' => bill.user.email }.to_json, 

    :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )
  end
  
end