json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :notes, :alert, :bill_id
  json.url reminder_url(reminder, format: :json)
end
