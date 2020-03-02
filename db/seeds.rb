# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Trip.create({start_date: Time.now.to_date,
             end_date: (Time.now.to_date + 20),
             gender: 'female',
             age: 29,
             origin: 'Buenos Aires',
             purpose: 'pleasure',
             location: 'Paris, France'
             name: 'my trip to paris'})

Task.create({
  trip_id: 1,
  name: "Visa",
  description: "description",
  status: "open",
  tip: "tip"
})

Task.create({
  trip_id: 1,
  name: "Prepare bag",
  description: "description",
  status: "open",
  tip: "tip"
})

morgan = User.create(email: "morgan@planit.wtf", password: "testtest", first_name: "Morgan")
jose = User.create(email: "jose@planit.wtf", password: "testtest", first_name: "Jose")
ben = User.create(email: "ben@planit.wtf", password: "testtest", first_name: "Ben")
manuel = User.create(email: "manuel@planit.wtf", password: "testtest", first_name: "Manuel")
