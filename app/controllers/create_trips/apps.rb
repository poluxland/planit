def apps(trip)
  # Create Task
  @task = Task.new(tip: nil, name: "Install some helpful apps", description: "We have prepared some helpful apps for your trip.", category: 'apps')
  @task.trip = trip
  @task.save

  @arrival_destination = @trip.location.split(', ')[-1].downcase.capitalize!

  def save_subtask
    subtask = Subtask.new(name: @name,description: @description)
    subtask.task = @task
    subtask.save
  end

  # Create Subtask S

  case @arrival_destination

  when "Argentina"

    @name = "Cuando Subo and Como Llego"
    @description = "Great apps for checking bus routes, stops and arrivals."
    save_subtask

    @name = "Rappi"
    @description = "Getting late to your booked lodging? Order some take out."
    save_subtask

    @name = "Cabify"
    @description = "Get where you need to go, fast and comfortable."
    save_subtask

  when "People's republic of china"

    @name = "DiDi"
    @description = "This is the main ride hailing company in #{@arrival_destination}. It will get you where you need to go, fast and comfortable."
    save_subtask

    @name = "Uber"
    @description = "You also have Uber in #{@arrival_destination}."
    save_subtask

  else

    @uber_countries = ["Argentina","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Belarus","Belgium","Bolivia","Brazil","Bulgaria","Cambodia","Canada","Chile","People's republic of china","Colombia","Costa rica","Croatia","Czech republic","Denmark","Dominican republic","Ecuador","Egypt","El salvador","Estonia","Finland","France","Germany","Ghana","Greece","Guatemala","Hong kong","Hungary","India","Indonesia","Ireland","Israel","Italy","Japan","Jordan","Kazakhstan","Kenya","Korea","South korea","Lebanon","Lithuania","Macao","Malaysia","Mauritius","Mexico","Morocco","Myanmar","Netherlands","New zealand","Nigeria","Norway","Pakistan","Panama","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russia","Saudi arabia","Singapore","Slovakia","South africa","Spain","Sri lanka","Sweden","Switzerland","Taiwan","Tanzania","Thailand","Trinidad and tobago","Turkey","Uganda","Ukraine","United arab emirates","United kingdom","United states of america","Uruguay","Vietnam"]
    @name = "Uber"
    if @uber_countries.include?(@arrival_destination)
      @description = "Works like a charm in #{@arrival_destination}."
    else
      @description = "Still has not deployed in #{@arrival_destination}."
    end
    save_subtask

    @name = "MapsMe"
    @description = "Great offline maps for your trip - You can download #{@destination} before."
    save_subtask

    @name = "Tripadvisor"
    @description = "Great for reviews and to find things to do."
    save_subtask

  end


end
