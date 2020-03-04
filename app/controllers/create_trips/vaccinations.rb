def vaccinations(trip)
  # Create Task
  @task = Task.new(name: "Get vaccinated", description: "You might need to get vaccinated for #{@destination}. Check with your doctor.")
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S
  @name = "Yellow Fever"
  @description = "Highly recommended for warmer countries"
  save_subtask

  @name = "Measles-mumps-rubella"
  @description = "Highly recommended"
  save_subtask

  @name = "Diphtheria-tetanus-pertussis"
  @description = "Highly recommended"
  save_subtask

  @name = "Varicella (chickenpox)"
  @description = "Highly recommended"
  save_subtask

  @name = "Polio"
  @description = "Highly recommended"
  save_subtask

  @name = "Influenza"
  @description = "Highly recommended"
  save_subtask

  @name = "Rabies"
  @description = "Optional, but recoomended if you are planning to get in contact with animals (e.g. stray dogs)"
  save_subtask
end
