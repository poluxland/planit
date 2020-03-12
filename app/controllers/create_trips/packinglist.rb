def packinglist(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Packing List", description: "Your personal packing list for #{@gender} travellers and a trip lasting #{@trip_length} days. We expect up to #{@max_temp_c.to_i.round(0)} Degree Celsius at that time of the year.", category: 'packing_list')
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S


  @arrival_destination = @trip.location.split(', ')[-1].downcase.capitalize!
  @departure_destination = @trip.origin.split(', ')[-1].downcase.capitalize!

  plug_table = CSV.parse(File.read("#{Rails.root}/public/volt.csv"), headers: true)
  #row = plug_table.find {|row| row["country"] == "Chile"}
  row = plug_table.find {|i| i[0] == "#{@arrival_destination}"}
  row2 = plug_table.find {|i| i[0] == "#{@departure_destination}"}

  if row.nil?
  @name = "Plug adapter"
  @description = "We recommend bringing a plug adapter"
  save_subtask

  elsif row2.nil?
  @name = "Plug adapter"
  @description = "We recommend bringing a plug adapter"
  save_subtask

  elsif @departure_destination == @arrival_destination
  @name = "Plug adapter"
  @description = "You are traveling in the same country, so nothing to worry about"
  save_subtask

  else
  count = row[0]
  volt = row[1]
  freq = row[2]
  plug = row[3]
  count_o = row2[0]
  volt_o = row2[1]
  freq_o = row2[2]
  plug_o = row2[3]

    if plug == plug_o && freq == freq_o
      @name = "Plug adapter"
      @description = "In #{count} and in #{count_o}, they have the same kind of plug #{plug} and same #{volt_o}V but if you plan to travel to another country after bring you plug adapter"
      save_subtask
    else

    @name = "Plug adapter"
    @description = "In #{count}, they use #{volt}V #{freq}Hz and #{plug} kind of plug and in #{count_o}, they use #{volt_o}V #{freq_o}Hz and #{plug_o} kind of plug: Bring your adapter https://www.worldstandards.eu/electricity/plugs-and-sockets/"
    save_subtask
    end
  end


    # Basics
    @name = "Shoes"
    @description = "Recommendation: 2x pairs"
    save_subtask

    @name = "Underwear"
    @description = "Recommendation: #{@trip_length > 7 ? 7 : @trip_length} pairs"
    save_subtask

    @name = "Trousers"
    @trousers = (@trip_length / 3.to_f).ceil
    @description = "Recommendation: #{@trousers > 3 ? 3 : @trousers} pairs"
    save_subtask

    @name = "Tshirts"
    @description = "Recommendation: #{@trip_length > 7 ? 7 : @trip_length} pairs"
    save_subtask

    @name = "Passport"
    @description = "Highly important"
    save_subtask

    @name = "Creditcard"
    @description = "Highly important"
    save_subtask

    @name = "Booking confirmations"
    @description = "Highly important"
    save_subtask

    @name = "Visa"
    @description = "Highly important"
    save_subtask

    @name = "Pen & Paper"
    @description = "Usually helpful (e.g. for filling out immigration"
    save_subtask


    @name = "Glases (if required)"
    @description = "Highly important"
    save_subtask

    @name = "Books / eBook reader"
    @description = "Highly important, when you like to read"
    save_subtask

    @name = "Phone"
    @description = "Highly important"
    save_subtask

    @name = "Phone charger"
    @description = "Highly important"
    save_subtask

    @name = "Toiletries"
    @description = "Toothpase, toothbrush, shampoo, soap and all the other stuff you might need"
    save_subtask


    if @max_temp_c > 20

      @name = "Sunglases"
      @description = "We expect warm weather"
      save_subtask

      @name = "Beach towel"
      @description = "We expect warm weather"
      save_subtask

      @name = "Sunscreen"
      @description = "We expect warm weather"
      save_subtask

      @name = "Bathing suit"
      @description = "We expect warm weather"
      save_subtask


    elsif @max_temp_c > 10

      @name = "Winter jacket"
      @description = "We expect cold weather"
      save_subtask

      @name = "Pullover"
      @pullover = (@trip_length / 3.to_f).ceil
      @description = "Recommendation: #{@pullover > 3 ? 3 : @pullover} pullovers"
      save_subtask

    elsif @min_temp_c > 0

      @name = "Winter gloves"
      @description = "We expect cold weather"
      save_subtask

    end

    if @min_temp_c <= 0 && @rainfall > 0.5

      @name = "Snow Jacket"
      @description = "We expect below zero temperatures"
      save_subtask

      @name = "Snow Boots"
      @description = "You may be walking on snow"
      save_subtask

    end








    # if row.nil?

    #   @name = "Get your passport!"
    #   @description = "Check the expiration date"
    #   save_subtask

    #   @name = "Get your Visa!"
    #   @description = "Check the requirements with the embassy"
    #   save_subtask
    # else
    #   code = row['Code']

    #   if code.to_s.scan(/\D/).empty?
    #     @name = "Get your passport!"
    #     @description = "Check the expiration date"
    #     save_subtask
    #   else
    #     @name = "Get your passport!"
    #     @description = "Check the expiration date"
    #     save_subtask

    #     @name = "Get your Visa!"
    #     @description = "Check the requirements with the embassy"
    #     save_subtask
    #   end
    # end








end
