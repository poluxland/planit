require 'json'
require 'open-uri'

def get_weather

  url = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=956a0318e456439aaa9164541200403&avgMinTemp&avgMaxTemp&q=#{@trip.latitude},#{@trip.longitude}&format=json"

  weather_serialized = open(url).read

  if !JSON.parse(weather_serialized)["data"]["error"].empty?
    output = JSON.parse(weather_serialized)["data"]["ClimateAverages"][0]["month"]
  else
    output = 0
  end

  return output
end
