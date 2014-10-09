class SendWorker

include Sidekiq::Worker

@@token = "553847b4acee36b1a82d8ade591ca51a"

  if self.contact_method == 'text'
    HTTParty.post("http://localhost:8080/texts.json", 
      :body => {
        'event_recurrence' => {
          'object_id' => self.id,
          'end_date' => 1.year.from_now,
          'every' => self.every,
          'start_date' => self.duedate}, 
        'text' => { 
          'cell_phone' => self.user.cell_phone,
          'text_reminder' => "This is a reminder that your #{self.provider.name} bill is due tomorrow. #{self.provider.url}"
        }
         }.to_json, 
      
      :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )
 
  elsif self.contact_method == 'phone call'

    HTTParty.post("http://localhost:8080/calls.json", 
      :body => {
        'event_recurrence' => {
          'object_id' => self.id,
          'end_date' => 1.year.from_now,
          'every' => self.every,
          'start_date' => self.duedate}, 
        'call' => { 
          'cell_phone' => self.user.cell_phone,
          'call_reminder' => "Hello #{self.user.first_name}. This is a friendly reminder that your #{self.provider.name}, #{self.category.name} bill is due tomorrow. Thank you for using Forget Me Not. GoodBye!"
        }
         }.to_json, 
      
      :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )

  elsif self.contact_method == 'email'

    HTTParty.post("http://localhost:8080/emails.json", 
      :body => {
        'event_recurrence' => {
          'object_id' => self.id,
          'end_date' => 1.year.from_now,
          'every' => self.every,
          'start_date' => self.duedate}, 
        'email' => { 
          'email_address' => self.user.email,
          'email_reminder' => "Hello #{self.user.first_name}. This is a friendly reminder that your #{self.provider.name}, #{self.category.name} bill is due tomorrow. Thank you for using Forget Me Not"

        }
         }.to_json, 
      
      :headers => { 
        'Authorization' => "Token token=#{@@token}",
        'Content-Type' => 'application/json',
        'Accept' => "application/json" } )
  end

end