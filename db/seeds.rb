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


