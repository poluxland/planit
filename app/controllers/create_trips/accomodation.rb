def accomodation(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Book your accomodation", description: "Make sure you have a place to stay for at least the first few days - Immigration might ask you for it.")
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S
  @name = "Accommodation upon arrival in #{trip.location}."
  @description = "At least for the first night!"
  save_subtask

end
