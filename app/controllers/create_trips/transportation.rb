def transportation(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Book your ship/flight/bus/train", description: "Book your transportaiton to get from #{@origin} to #{@destination}.")
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtasks

end
