require 'json'
require 'open-uri'

def get_weather
  url = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=956a0318e456439aaa9164541200403&avgMinTemp&avgMaxTemp&q=#{@trip.latitude},#{@trip.longitude}&format=json"

  weather_serialized = open(url).read

  weather = JSON.parse(weather_serialized)["data"]["ClimateAverages"][0]["month"]

  return weather
end
