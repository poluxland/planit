def packinglist(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Packing List", description: "Your personal packing list for #{@gender} travellers and a trip lasting #{@trip_length} days. We expect up to #{@max_temp.to_i.round(0)} Degree Celsius at that time of the year.", category: 'packing_list')
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S

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

end
