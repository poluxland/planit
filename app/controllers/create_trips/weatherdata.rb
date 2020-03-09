require 'json'
require 'open-uri'

def get_weather

  url = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{ENV["WORLD_WEATHER_API_KEY"]}&avgMinTemp&avgMaxTemp&q=#{@trip.latitude},#{@trip.longitude}&format=json"

  weather_serialized = open(url).read

  # if !JSON.parse(weather_serialized)["data"]["error"].empty?
  if true
    output = JSON.parse(weather_serialized)["data"]["ClimateAverages"][0]["month"]
    output = output[(@start_date.month - 1)]["absMaxTemp"].to_i
  else
    output = 0
  end

  return output
end
