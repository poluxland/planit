def apps(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Some helpful apps", description: "We have prepared some helpful apps for your trip.", category: 'apps')
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S

  @name = "MapsMe"
  @description = "Great offline maps for your trip - You can download #{@destination} before"
  save_subtask

  @name = "Uber"
  @description = "Works like a charm in #{@destination}"
  save_subtask

  @name = "Tripadvisor"
  @description = "Great for reviews and to find things to do"
  save_subtask
end
