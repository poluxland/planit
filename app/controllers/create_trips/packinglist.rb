def packinglist(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Packing List", description: "Your personal packing list for #{@gender} travellers and a trip lasting #{@trip_length} days.")
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

    @name = "Belt"
    @description = "Recommendation: 1x"
    save_subtask

    @name = "Underwear"
    @description = "Recommendation: #{@trip_length}x"
    save_subtask

    @name = "Socks"
    @description = "Recommendation: #{@trip_length}x"
    save_subtask

    @name = "Trousers"
    @description = "Recommendation: #{@trip_length / 3}x"
    save_subtask

    @name = "Tshirts"
    @description = "Recommendation: #{@trip_length}x"
    save_subtask

    @name = "Pullover"
    @description = "Recommendation: #{@trip_length / 3}x"
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

    @name = "Sunglases"
    @description = "It might be sunny :)"
    save_subtask

    @name = "Glases (if required)"
    @description = "Highly important"
    save_subtask

    @name = "Beach towel"
    @description = "Helpful for daytrips"
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
    @description = "Toothpase, toothbrush, suncreen, shampoo, soap and all the other stuff you might need"
    save_subtask
end
