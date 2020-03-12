# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.delete_all
Trip.delete_all
User.delete_all

morgan = User.create!(email: "morgan@planit.wtf", password: "testtest", first_name: "Morgan")
jose = User.create!(email: "jose@planit.wtf", password: "testtest", first_name: "Jose")
ben = User.create!(email: "ben@planit.wtf", password: "testtest", first_name: "Ben")
manuel = User.create!(email: "manuel@planit.wtf", password: "testtest", first_name: "Manuel")

Trip.create!({start_date: Time.now.to_date,
             end_date: (Time.now.to_date + 20),
             gender: 'female',
             age: 29,
             origin: 'Buenos Aires',
             purpose: 'pleasure',
             location: 'Paris, France',
             name: 'my trip to paris',
             description: 'This is my trip to paris, I am going next year',
             user_id: User.first.id})

Task.create!({
  trip_id: Trip.first.id,
  name: "Visa",
  description: "Go get that Visa!",
  status: "open",
  tip: "tip"
})

Task.create!({
  trip_id: Trip.first.id,
  name: "Prepare bag",
  description: "What are you waiting for? The last minute?",
  status: "open",
  tip: "tip"
})

chatroom = ChatRoom.create(name: 'chatroom')

