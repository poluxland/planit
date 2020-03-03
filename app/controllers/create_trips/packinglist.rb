def packinglist(trip)
  packinglist = Task.new(name: "Packing List", description: "Your personal packing list")
  packinglist.trip = trip
  packinglist.save
end
