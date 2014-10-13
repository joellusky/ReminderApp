class LocationJob

  include SuckerPunch::Job

  def perform(user_id)

    user = User.find(user_id)
    ip = user.last_sign_in_ip
    response = HTTParty.get("http://www.freegeoip.net/json/#{ip}")
    a = JSON.parse(response.body)
    user.country = a["country_name"]
    user.save
  end

end