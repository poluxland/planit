require 'json'
require 'open-uri'
require "nokogiri"

def money(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Let's speak money ", description: "We have some currency advice for your trip.", category: 'money')
  @task.trip = trip
  @task.save

  @arrival_country = @trip.location.split(', ')[-1]
  @city_arrival = @trip.location.split(', ')[0].gsub(/ /, '-').downcase

  @departure_country = @trip.origin.split(', ')[-1]


  # What is the curency
  def currency_finder(country)
    begin
      url_country = "https://restcountries.eu/rest/v2/name/#{country}"
      url_destination_format = URI::encode(url_country)
      curency_serialized = open(url_destination_format).read
      curency_code = JSON.parse(curency_serialized).first["currencies"].first["code"]
      curency_name = JSON.parse(curency_serialized).first["currencies"].first["name"]
      curency_symbol = JSON.parse(curency_serialized).first["currencies"].first["symbol"]
      curency = {
        code: curency_code,
        name: curency_name,
        symbol: curency_symbol
      }
      return curency
    rescue Exception => e
      {
        code: "N/A",
        name: "N/A",
        symbol: "N/A"
      }
    end
  end

  #the rate
  def exchange_rate(departure_currency, arival_curency)
    url_rate = "http://data.fixer.io/api/latest?access_key=458ca856b29f0fd8bb9eaefbc162d361&format=1"
    exchange_rate_serialized = open(url_rate).read
    rate_departure_currency = JSON.parse(exchange_rate_serialized)["rates"][departure_currency]
    rate_arrival_currency = JSON.parse(exchange_rate_serialized)["rates"][arival_curency]
    # 1 unity of the dep currency is = to x of the arri => answer in forgein curency
    rate = (rate_arrival_currency/rate_departure_currency) rescue 1
    return rate
  end

  #cost of leaving
  # def cost_of_living(destination)
  #   ScraperHelper.get_average_cost(destination)
  # end


  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  @cureny_code_description_arrival = currency_finder(@arrival_country)[:code]
  @cureny_code_description_departure = currency_finder(@departure_country)[:code]

  @cureny_name_description_arrival = currency_finder(@arrival_country)[:name]

  @cureny_symbol_description_arrival = currency_finder(@arrival_country)[:symbol]

  @rate = exchange_rate(@cureny_code_description_departure, @cureny_code_description_arrival)

  @rate_us = exchange_rate("USD",@cureny_code_description_departure)


  @cost_of_living_for_x_day = ScraperHelper::get_average_cost(@city_arrival)[:cost_of_leaving]
  @suggested_atm_city = ScraperHelper::get_suggested_atm(@city_arrival)[:suggested_atm]



  if @cost_of_living_for_x_day
    @name = "Make sure you grab enough money"
    @description = "As you are traveling for #{@trip_length} day(s), we would recommend to take in total #{(@trip_length * @cost_of_living_for_x_day * @rate_us).round(0)} #{@cureny_code_description_departure}"
    save_subtask
  end

  if @suggested_atm_city
    @name = "Make sure to wiwdrow the right amount"
    @description ="In #{@arrival_country} we recommend to wiwdrow #{(@suggested_atm_city * @rate_us).round(0)} #{@cureny_code_description_departure} at once."
    save_subtask
  end

  @name = "Make sure to change some money"
  @description = "In #{@arrival_country}, they use the #{@cureny_name_description_arrival} (#{@cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
  Today for for 10 #{@cureny_code_description_departure} you will have #{(@rate * 10).round(2)} #{@cureny_code_description_arrival}."
  save_subtask

end

