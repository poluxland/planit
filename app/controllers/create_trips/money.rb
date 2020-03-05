require 'json'
require 'open-uri'
require "nokogiri"
require 'byebug'


def money(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Let's speak monney ", description: "We have prepared some helpful apps for your trip.")
  @task.trip = trip
  @task.save
  @departure_destination = @trip.origin.split(',')[-1]
  @arival_destination = @trip.location.split(',')[-1]


  # What is the curency
  def currency_finder(destination)
    url_destination = "https://restcountries.eu/rest/v2/name/#{destination}"
    curency_serialized = open(url_destination).read
    curency_code = JSON.parse(curency_serialized).first["currencies"].first["code"]
    curency_name = JSON.parse(curency_serialized).first["currencies"].first["name"]
    curency_symbol = JSON.parse(curency_serialized).first["currencies"].first["symbol"]
    curency = {
      code: curency_code,
      name: curency_name,
      symbol: curency_symbol
    }
    return curency
  end

  #the rate
  def exchange_rate(departure_currency, arival_curency)
    url_rate = "http://data.fixer.io/api/latest?access_key=458ca856b29f0fd8bb9eaefbc162d361&format=1"
    exchange_rate_serialized = open(url_rate).read
    byebug
    rate_departure_currency = JSON.parse(exchange_rate_serialized)["rates"][departure_currency]
    rate_arrival_currency = JSON.parse(exchange_rate_serialized)["rates"][arival_curency]
    # 1 unity of the initial currency is = to x of the arri
    rate = (rate_arrival_currency/rate_departure_currency)
    return rate
  end

  def how_much_cash(destination)
    city_page_url = "https://nomadlist.com/cost-of-living/in/#{destination}"
    unparsed_page = open(city_page_url).read
    parsed_page = Nokogiri::HTML(unparsed_page)
    cost_of_living = parsed_page.css
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

  @rate = exchange_rate(cureny_code_description_departure, cureny_code_description_arrival)

  @name = "Make sure to change some money"
  @description = "In #{@arival_destination}, they use the #{@cureny_name_description_arrival} (#{cureny_symbol_description_arrival} #{@cureny_code_description_arrival}).
  Today for for 10 #{cureny_code_description_departure} you will have #{rate * 10}"
  save_subtask

end

# def language(destination)
#   language = JSON.parse(curency_serialized).first["languages"].first["name"]
# end
















#   # Create Subtask S


#   # @name = "Uber"
#   # @description = "Works like a charm in #{@destination}"
#   # save_subtask

#   # @name = "Tripadivsor"
#   # @description = "Great for reviews and to find things to do"
#   # save_subtask




