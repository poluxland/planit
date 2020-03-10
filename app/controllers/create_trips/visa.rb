require 'csv'
def visa(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Get your visa", description: "You might need a visa for #{@destination}. Check with your foreign minstry.", category: 'visa')
  @task.trip = trip
  @task.save


  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end



  @arrival_destination = @trip.location.split(', ')[-1].downcase.capitalize!
  @departure_destination = @trip.origin.split(', ')[-1].downcase.capitalize!

  table = CSV.parse(File.read("#{Rails.root}/public/passport.csv"), headers: true)
  row = table.find {|row| row['Passport'] == "#{@departure_destination}" && row["Destination"] == "#{@arrival_destination}"}


  if @departure_destination == @arrival_destination
    @task = Task.new(tip: nil, name: "Visa requirements", description: "If you are from #{@departure_destination} and you travel to #{@arrival_destination} you don't need a Visa because you are in the same country")
    @task.trip = trip
    @task.save

    @name = "Get your ID!"
    @description = "Check the expiration date"
    save_subtask
  else



    if row.nil?
      @task = Task.new(tip: nil, name: "Visa requirements", description: "You need to check the requirements with the country")
      @task.trip = trip
      @task.save

      @name = "Get your passport!"
      @description = "Check the expiration date"
      save_subtask

      @name = "Get your Visa!"
      @description = "Check the requirements with the embassy"
      save_subtask



    else
      code = row['Code']

      if code.to_s.scan(/\D/).empty?
        @task = Task.new(tip: nil, name: "Visa requirements", description: "If you are from #{@departure_destination} and you travel to #{@arrival_destination} you can travel for #{code} days without a Visa.")
        @task.trip = trip
        @task.save

        @name = "Get your passport!"
        @description = "Check the expiration date"
        save_subtask
      else
        @task = Task.new(tip: nil, name: "Visa requirements", description: "If you are from #{@departure_destination} and you travel to #{@arrival_destination} you need a Visa")
        @task.trip = trip
        @task.save

        @name = "Get your passport!"
        @description = "Check the expiration date"
        save_subtask

        @name = "Get your Visa!"
        @description = "Check the requirements with the embassy"
        save_subtask

      end
    end
  end
end
