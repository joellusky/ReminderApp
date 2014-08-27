json.array!(@bills) do |bill|
  json.extract! bill, :id, :name, :duedate, :category_id, :url
  json.url bill_url(bill, format: :json)
end
