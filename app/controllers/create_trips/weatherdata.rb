require 'json'
require 'open-uri'

def get_weather
  url = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{ENV["WORLD_WEATHER_API_KEY"]}&avgMinTemp&avgMaxTemp&q=#{@trip.latitude},#{@trip.longitude}&format=json"

  weather_serialized = open(url).read

  weather = JSON.parse(weather_serialized)["data"]["ClimateAverages"][0]["month"]

  return weather
end
