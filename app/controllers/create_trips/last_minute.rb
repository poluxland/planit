def last_minute(trip)
  # Create Task
  @task = Task.new(name: "Last minute preparations", description: "Some recommended last minute checks before leaving.")
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S

  @name = "Make sure you have all documents with you"
  @description = "Passport, Credit card, cash, booking confirmations and visa!"
  save_subtask

  @name = "Prepare the flat/ house"
  @description = "Make sure windows are closed, oven and lights are switched off"
  save_subtask

  @name = "Charge your phone"
  @description = "Make sure your phone is charged when you leave"
  save_subtask
end
