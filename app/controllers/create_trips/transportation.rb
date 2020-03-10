def transportation(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Book your ship/flight/bus/train", description: "Book your transportaiton to get from #{@origin} to #{@destination}.", category: 'transportation')
  @task.trip = trip
  @task.save

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtasks
    @name = "Ticker from #{@origin} to #{@destination}."
    @description = "Buy your ticket with time!"
    save_subtask

    @name = "Ticker from #{@destination} to #{@origin}."
    @description = "Buy your ticket with time!"
    save_subtask

end
