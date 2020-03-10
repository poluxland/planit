def vaccinations(trip)
  # Create Task
  @destination = @trip.location.split(', ')[-1].downcase.capitalize!

  if @max_temp_c > 23
    @notice = ", as it is really hot there at that time"
  elsif condition
    @notice = ", as it is really cold there at that time"
  else
    @notice = ""
  end

  @task = Task.new(tip: nil, name: "Get vaccinated", description: "You might need to get vaccinated for #{@destination}#{@notice}. Check with your doctor.", category: 'vaccinations')
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S


  if @max_temp_c > 23

    @name = "Yellow Fever"
    @description = "Highly recommended"
    save_subtask

    @name = "Dengue fever"
    @description = "Only recommended for people who had the disease"
    save_subtask

    @name = "Typhoid fever"
    @description = "Recommended if you plan to travel to rural areas"
    save_subtask

    @name = "Hepatitis A"
    @description = "Recommended if you plan to travel to rural areas"
    save_subtask

  elsif @max_temp_c < 16

    @name = "Influenza"
    @description = "Highly recommended"
    save_subtask


  end


  @name = "Hepatitis B"
  @description = "Only if you have risk to be in contact with blood or sexual fluids"
  save_subtask

  @name = "Rabies"
  @description = "Optional, but recoomended if you are planning to get in contact with animals (e.g. stray dogs)"
  save_subtask


end
