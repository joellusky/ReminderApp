class LocationJob

include SuckerPunch::Job

  def perform(user_id)

    user = User.find(user_id)

    ip = user.last_sign_in_ip
    response = Unirest.get "http://api.netimpact.com/qv1.php?key=yvnBK1wYiEwrmCHC&qt=geoip&d=json&q=#{ip}&qt=geoip",
    headers:{:X => "L90l5rQA7smshIUnQLnW4YYUc3kzp1VZhEZjsnUq2OaaQJwhol"}

    location = response.body

    user.country = location[0][2]
    user.save

  end

end