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

  if safty_test(@ar_country) == false || safty_test(@de_country) == false
    @name = "No information about your country!"
    @description = "We couldn't find information about this country, make sure to make you research"
    save_subtask
  else
    @safty_arrival = safty_test(@ar_country).to_i
    @safty_departure = safty_test(@de_country).to_i

    if @safty_arrival < @safty_departure
      @country_comparison = "#{@ar_country.capitalize} is less safe than #{@de_country.capitalize}"
    else
      @country_comparison = "#{@ar_country.capitalize} is more safe than #{@de_country.capitalize}"
    end

    case @safty_arrival
    when 0..40
      @name = "Be carefull!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is considered unsafe, it's score is #{@safty_arrival}/100. So you should think twice and try not to travel alone"
      save_subtask
    when 41..60
      @name = "Be carefull!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is not too safe but it's ok, it's score is #{@safty_arrival}/100. Travelling alone might not be a good idea"
      save_subtask
    when 61..80
      @name = "You should be ok!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is pretty safe place, it's score is #{@safty_arrival}/100. You can definitly travel by yourself"
      save_subtask
    when 80..100
      @name = "Safety won't be an issue!"
      @description = "#{@country_comparison}. #{@ar_country.capitalize} is a super safe place, it's score is #{@safty_arrival}/100. You can definitly travel by yourself"
      save_subtask
    end
  end


end

# @name = "Make sure to change some money"
# @description = "In #{@ar_country}, they use the #{@cureny_name_description_arrival} (#{@cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
# Today for for 10 #{@cureny_code_description_departure} you will have #{(@rate * 10).round(2)} #{@cureny_code_description_arrival}."
# save_subtask




