require 'open-uri'
require "nokogiri"


def safety(trip)

  @task = Task.new(tip: nil, name: "Stay safe", description: "Make sure to check the level of safety of your destination", category: 'safety')
  @task.trip = trip
  @task.save

  @ar_country = @trip.location.split(', ')[-1].gsub(/ /, '-').downcase
  @de_country = @trip.origin.split(', ')[-1].gsub(/ /, '-').downcase

  if @ar_country == "people's-republic-of-china"
    @ar_country = "china"
  end

  if @de_country == "people's-republic-of-china"
    @de_country = "china"
  end


  def safty_test(country)
    begin
      url_main_page = "https://ulsafetyindex.org/country/#{country}"
      unparsed_page = open(url_main_page).read
      parsed_page = Nokogiri::HTML(unparsed_page)
      score = parsed_page.css("h2")[1].text
      if score.nil?
        return false
      end
      return score
    rescue Exception => e
      return false
    end
  end

  def air_quality(city)
    url_main_page = "https://aqicn.org/city/#{city}"
    unparsed_page = open(url_main_page).read
    parsed_page = Nokogiri::HTML(unparsed_page)

    quality_score =  parsed_page.css("#aqiwgtvalue").first

    if quality_score.nil?
      return false
    else
      quality_score_data =  parsed_page.css("#aqiwgtvalue").text.to_i
      return quality_score_data
    end
  end

  @city_arrival = @trip.location.split(', ')[0].gsub(/ /, '-').downcase
  @city_arrival_nice = @trip.location.split(', ')[0]
  @city_arrival_air_quality = air_quality(@city_arrival)


  @city_departure = @trip.origin.split(', ')[0].gsub(/ /, '-').downcase
  @city_departure_nice = @trip.origin.split(', ')[0]
  @city_departure_air_quality = air_quality(@city_departure)

  puts "______________________________________________"
  p @city_arrival_air_quality
  puts "______________________________________________"
  p @city_departure_air_quality
  p @city_arrival
  puts "______________________________________________"

  unless @city_departure_air_quality == false || @city_arrival_air_quality == false
    case @city_arrival_air_quality
    when 0..50
      @name = "The air quality is good"
      @description = "The pollution level in #{@city_arrival_nice} is considered good with a score of #{@city_arrival_air_quality} (the lower the better).
      In comparison, #{@city_departure_nice} has a score of #{@city_departure_air_quality}."
      save_subtask
    when 51..100
      @name = "The air quality is modarate"
      @description = "The pollution level in #{@city_arrival_nice} is considered moderate with a score of #{@city_arrival_air_quality} (the lower the better).
      In comparison, #{@city_departure_nice} has a score of #{@city_departure_air_quality}."
      save_subtask
    when 101..150
      @name = "The air quality is bad, be careful"
      @description = "The pollution level in #{@city_arrival_nice} is considered unhealthy with a score of #{@city_arrival_air_quality} (the lower the better).
      In comparison, #{@city_departure_nice} has a score of #{@city_departure_air_quality}. A mask can be a good idea."
      save_subtask
    when 151..200
      @name = "The air quality is really bad, be careful"
      @description = "The pollution level in #{@city_arrival_nice} is considered really unhealthy with a score of #{@city_arrival_air_quality} (the lower the better).
      In comparison, #{@city_departure_nice} has a score of #{@city_departure_air_quality}. We higly recommend to wear a mask."
      save_subtask
    when 201..250
      @name = "The air quality is terrible, be careful"
      @description = "The pollution level in #{@city_arrival_nice} is considered very bad with a score of #{@city_arrival_air_quality} (the lower the better).
      In comparison, #{@city_departure_nice} has a score of #{@city_departure_air_quality}. We recommend to wear a mask, really!"
      save_subtask
    end
  end



  if safty_test(@ar_country) == false || safty_test(@de_country) == false
    @name = "No information about your country!"
    @description = "We couldn't find information about this country, make sure to look the information up yourself!"
    save_subtask
  else
    @safty_arrival = safty_test(@ar_country).to_i
    @safty_departure = safty_test(@de_country).to_i

    if @safty_arrival < @safty_departure
      @country_comparison = "#{@ar_country.capitalize} is less safe than #{@de_country.capitalize}."
    else
      @country_comparison = "#{@ar_country.capitalize} is safer than #{@de_country.capitalize}."
    end

    case @safty_arrival
    when 0..40
      @name = "Be carefull!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is considered unsafe, it's score is #{@safty_arrival}/100. So you should think twice and try not to travel alone."
      save_subtask
    when 41..60
      @name = "Be carefull!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is not too safe, but it's ok. It's score is #{@safty_arrival}/100. Travelling alone might not be a good idea."
      save_subtask
    when 61..80
      @name = "You should be ok!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is a pretty safe place. It's score is #{@safty_arrival}/100. You can definitely travel by yourself."
      save_subtask
    when 80..100
      @name = "Safety won't be an issue!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is a super safe place, it's score is #{@safty_arrival}/100. You can definitely travel by yourself."
      save_subtask
    end
  end

end

# @name = "Make sure to change some money"
# @description = "In #{@ar_country}, they use the #{@cureny_name_description_arrival} (#{@cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
# Today for for 10 #{@cureny_code_description_departure} you will have #{(@rate * 10).round(2)} #{@cureny_code_description_arrival}."
# save_subtask




