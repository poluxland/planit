require 'json'
require 'open-uri'
require "nokogiri"

def money(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Let's speak monney ", description: "We have prepared some helpful apps for your trip.")
  @task.trip = trip
  @task.save

  @arival_destination = @trip.location.split(', ')[-1].downcase
  @city_arival_destination = @trip.location.split(', ')[0].gsub(/ /, '-').downcase

  @departure_destination = @trip.origin.split(', ')[-1].downcase


  # What is the curency
  def currency_finder(destination)
    begin
      url_destination = "https://restcountries.eu/rest/v2/name/#{destination}"
      url_destination_format = URI::encode(url_destination)
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
    rate = (rate_arrival_currency/rate_departure_currency)
    return rate
  end

  #cost of leaving
  def cost_of_living(destination)
    ScraperHelper.get_average_cost(destination)
    # browser.goto("https://nomadlist.com/cost-of-living/in/#{destination}")
    # test = browser.css(".tab-cost-of-living .details > tbody > tr:nth-child(2) > td").last
    # if test.nil?
    #   return false
    # else
    #   cost_expat = browser.css(".tab-cost-of-living .details > tbody > tr:nth-child(2) > td").last.text
    #   cost_nomad = browser.css(".tab-cost-of-living .details > tbody > tr:nth-child(1) > td").last.text.split(" / ")[0].gsub(/[$,]/, "").to_f
    #   avr_cost_pd = ((cost_expat+cost_nomad)/2)/30
    #   return avr_cost_pd
    #   browser.quit
    # end
  end


  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  @cureny_code_description_arrival = currency_finder(@arival_destination)[:code]
  @cureny_code_description_departure = currency_finder(@departure_destination)[:code]

  @cureny_name_description_arrival = currency_finder(@arival_destination)[:name]

  @cureny_symbol_description_arrival = currency_finder(@arival_destination)[:symbol]

  @rate = exchange_rate(@cureny_code_description_departure, @cureny_code_description_arrival)

  @rate_us = exchange_rate("USD",@cureny_code_description_departure)


  @cost_of_living_for_x_day = ScraperHelper::get_average_cost(@city_arival_destination)

  #subtask


  @name = "Make sure you grab enough money"
  if @cost_of_living_for_x_day
    @description = "As you are traveling for #{@trip_length} day, we would recommand to take in total #{(@trip_length * @cost_of_living_for_x_day * @rate_us).round(0)} #{@cureny_code_description_departure}"
  else
    @description = "We didn't find have information for the country you are going but, we would recommand check website."
  end
  save_subtask

  @name = "Make sure to change some money"
  @description = "In #{@arival_destination}, they use the #{@cureny_name_description_arrival} (#{@cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
  Today for for 10 #{@cureny_code_description_departure} you will have #{(@rate * 10).round(2)} #{@cureny_code_description_arrival}."
  save_subtask

end

