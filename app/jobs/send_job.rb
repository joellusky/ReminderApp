class SendJob

include SuckerPunch::Job


@@token = "11bbad9f27d1494f8d8570db1ba4855a"

  def perform(bill_id)

    bill = Bill.find(bill_id)

    if bill.contact_method == 'text'
      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/texts.json", 
        :body => {
          'event_recurrence' => {
            'object_id' => bill.id,
            'end_date' => 1.year.from_now,
            'every' => bill.every,
            'start_date' => bill.duedate}, 
          'text' => { 
            'cell_phone' => bill.user.cell_phone,
            'text_reminder' => "This is a reminder that your #{bill.provider.name} bill is due tomorrow. #{bill.provider.url}"
          }
           }.to_json, 
        
        :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )

    elsif bill.contact_method == 'phone call'

      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/calls.json", 
        :body => {
          'event_recurrence' => {
            'object_id' => bill.id,
            'end_date' => 1.year.from_now,
            'every' => bill.every,
            'start_date' => bill.duedate}, 
          'call' => { 
            'cell_phone' => bill.user.cell_phone,
            'call_reminder' => "Hello #{bill.user.first_name}. This is a friendly reminder that your #{bill.provider.name}, #{bill.category.name} bill is due tomorrow. Thank you for using Forget Me Not. GoodBye!"
          }
           }.to_json, 
        
        :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )

    elsif bill.contact_method == 'email'

      HTTParty.post("http://sleepy-citadel-7753.herokuapp.com/emails.json", 
        :body => {
          'event_recurrence' => {
            'object_id' => bill.id,
            'end_date' => 1.year.from_now,
            'every' => bill.every,
            'start_date' => bill.duedate}, 
          'email' => { 
            'email_address' => bill.user.email,
            'email_reminder' => "Hello #{bill.user.first_name}. This is a friendly reminder that your #{bill.provider.name}, #{bill.category.name} bill is due tomorrow. Thank you for using Forget Me Not"

          }
           }.to_json, 
        
        :headers => { 
          'Authorization' => "Token token=#{@@token}",
          'Content-Type' => 'application/json',
          'Accept' => "application/json" } )
    end
  end
  
end