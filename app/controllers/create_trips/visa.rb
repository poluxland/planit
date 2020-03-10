def visa(trip)
  # Create Task
  require 'csv'



  @arrival_destination = @trip.location.split(', ')[-1].downcase.capitalize!
  @departure_destination = @trip.origin.split(', ')[-1].downcase.capitalize!

  table = CSV.parse(File.read("#{Rails.root}/public/passport.csv"), headers: true)
  row = table.find {|row| row['Passport'] == "#{@departure_destination}" && row["Destination"] == "#{@arrival_destination}"}


  code = row['Code']


  @task = Task.new(tip: nil, name: "Visa requirements", description: "If you are from #{@departure_destination} and you travel to #{@arrival_destination} you can travel for #{code} days without a Visa.")
  @task.trip = trip
  @task.save




  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end


    @name = "Get your passport!"
    @description = "Check the expiration date"
    save_subtask

end
