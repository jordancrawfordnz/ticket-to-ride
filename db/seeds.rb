# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TrainCarType.create(name: "Locomotive", total: 14)
TrainCarType.create(name: "Box", total: 12)
TrainCarType.create(name: "Passenger", total: 12)
TrainCarType.create(name: "Tanker", total: 12)
TrainCarType.create(name: "Reefer", total: 12)
TrainCarType.create(name: "Freight", total: 12)
TrainCarType.create(name: "Hopper", total: 12)
TrainCarType.create(name: "Coal", total: 12)
TrainCarType.create(name: "Caboose", total: 12)
