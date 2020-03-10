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

  require 'csv'
  #def visa?

    table = CSV.parse(File.read("#{Rails.root}/public/passport.csv"), headers: true)
    row = table.find {|row| row['Passport'] == 'Afghanistan' && row['Destination'] == 'Chile'}
    code = row['Code']

  #end

  # Create Subtask S
    #visa?()
    @name = "For travel to #{@destination} from #{@origin} you need #{code}."
    @description = "Get your visa!"
    save_subtask

end
