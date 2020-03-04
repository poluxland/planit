def visa(trip)
  # Create Task
  @task = Task.new(name: "Get your visa", description: "You might need a visa for #{@destination}. Check with your foreign minstry.")
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S

end
