def transportation(trip)
  @destination = @trip.location.split(', ')[0].downcase.capitalize!
  @origin = @trip.origin.split(', ')[0].downcase.capitalize!

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
    @name = "Ticket from #{@origin} to #{@destination}."
    @description = "Buy your ticket to get there!"
    save_subtask

    @name = "Ticket from #{@destination} to #{@origin}."
    @description = "Buy your ticket to get home!"
    save_subtask

end
