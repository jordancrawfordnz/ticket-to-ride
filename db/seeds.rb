# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TODO: Move away from using seeds in tests!
Game.destroy_all
City.destroy_all
RouteType.destroy_all
Player.destroy_all
Route.destroy_all
TrainCarType.destroy_all
DealtTrainCar.destroy_all

COLOURS = {
  multi: "Multi",
  purple: "Purple",
  white: "White",
  blue: "Blue",
  yellow: "Yellow",
  orange: "Orange",
  black: "Black",
  red: "Red",
  green: "Green",
  grey: "Grey"
}

# Setup the train car types.
[
  { name: "Locomotive", colour: COLOURS[:multi], wildcard: true, total: 14 },
  { name: "Box", colour: COLOURS[:purple], total: 12 },
  { name: "Passenger", colour: COLOURS[:white], total: 12 },
  { name: "Tanker", colour: COLOURS[:blue], total: 12 },
  { name: "Reefer", colour: COLOURS[:yellow],  total: 12 },
  { name: "Freight", colour: COLOURS[:orange], total: 12 },
  { name: "Hopper", colour: COLOURS[:black], total: 12 },
  { name: "Coal", colour: COLOURS[:red], total: 12 },
  { name: "Caboose", colour: COLOURS[:green], total: 12 }
].each do |train_car_type_details|
  TrainCarType.create!(train_car_type_details)
end

# Setup citys.
cities = {
  vancouver: "Vancouver",
  seattle: "Seattle",
  portland: "Portland",
  san_francisco: "San Francisco",
  salt_lake: "Salt Lake City",
  calgary: "Calgary",
  las_vegas: "Las Vegas",
  los_angeles: "Los Angeles",
  phoenix: "Phoenix",
  helena: "Helena",
  winnipeg: "Winnipeg",
  deluth: "Duluth",
  omaha: "Omaha",
  denver: "Denver",
  oklahoma: "Oklahoma City",
  santa_fe: "Santa Fe",
  el_paso: "El Paso",
  houston: "Houston",
  dallas: "Dallas",
  kansas: "Kansas City",
  sault_st_marie: "Sault St Marie",
  chicago: "Chicago",
  saint_louis: "Saint Louis",
  little_rock: "Little Rock",
  new_orleans: "New Orleans",
  miami: "Miami",
  alanta: "Alanta",
  nashville: "Nashville",
  charleston: "Charleston",
  raleigh: "Raleigh",
  washington: "Washington",
  pittsburgh: "Pittsburgh",
  new_york: "New York",
  toronto: "Toronto",
  boston: "Boston",
  montreal: "Montreal"
}

city_instances = cities.transform_values do |city_name|
  City.create!(name: city_name)
end

route_colours = [
                :grey,
                :white,
                :yellow,
                :purple,
                :green,
                :red,
                :orange,
                :blue,
                :black
              ]

route_type_instances = route_colours.each.with_object({}) do |colour, route_type_instances|
  route_type_instances[colour] = RouteType.create!(colour: COLOURS[colour])
end

# Setup routes between cities.
route_details = [
  [:vancouver, :calgary, route_type_instances[:grey], 3],
  [:vancouver, :seattle, route_type_instances[:grey], 1, 2],
  [:calgary, :seattle, route_type_instances[:grey], 4],
  [:calgary, :helena, route_type_instances[:grey], 4],
  [:calgary, :winnipeg, route_type_instances[:white], 6],
  [:helena, :seattle, route_type_instances[:yellow], 6],
  [:helena, :salt_lake, route_type_instances[:purple], 3],
  [:helena, :denver, route_type_instances[:green], 4],
  [:helena, :omaha, route_type_instances[:red], 5],
  [:helena, :deluth, route_type_instances[:orange], 6],
  [:helena, :winnipeg, route_type_instances[:blue], 4],
  [:winnipeg, :sault_st_marie, route_type_instances[:grey], 6],
  [:winnipeg, :deluth, route_type_instances[:black], 4],
  [:deluth, :omaha, route_type_instances[:grey], 2, 2],
  [:deluth, :chicago, route_type_instances[:red], 3],
  [:deluth, :toronto, route_type_instances[:purple], 6],
  [:deluth, :sault_st_marie, route_type_instances[:grey], 3],
  [:sault_st_marie, :montreal, route_type_instances[:black], 5],
  [:sault_st_marie, :toronto, route_type_instances[:grey], 2],
  [:montreal, :toronto, route_type_instances[:grey], 3],
  [:montreal, :new_york, route_type_instances[:blue], 3],
  [:montreal, :boston, route_type_instances[:grey], 2, 2],
  [:boston, :new_york, route_type_instances[:yellow], 2],
  [:boston, :new_york, route_type_instances[:red], 2],
  [:toronto, :pittsburgh, route_type_instances[:grey], 2],
  [:new_york, :washington, route_type_instances[:orange], 2],
  [:new_york, :washington, route_type_instances[:black], 2],
  [:new_york, :pittsburgh, route_type_instances[:white], 2],
  [:new_york, :pittsburgh, route_type_instances[:green], 2],
  [:pittsburgh, :washington, route_type_instances[:grey], 2],
  [:pittsburgh, :raleigh, route_type_instances[:grey], 2],
  [:pittsburgh, :nashville, route_type_instances[:yellow], 4],
  [:pittsburgh, :saint_louis, route_type_instances[:green], 5],
  [:chicago, :pittsburgh, route_type_instances[:orange], 3],
  [:chicago, :pittsburgh, route_type_instances[:black], 3],
  [:chicago, :saint_louis, route_type_instances[:green], 2],
  [:chicago, :saint_louis, route_type_instances[:white], 2],
  [:washington, :raleigh, route_type_instances[:grey], 2, 2],
  [:seattle, :portland, route_type_instances[:grey], 1, 2],
  [:portland, :salt_lake, route_type_instances[:blue], 6],
  [:portland, :san_francisco, route_type_instances[:green], 5],
  [:portland, :san_francisco, route_type_instances[:purple], 5],
  [:san_francisco, :salt_lake, route_type_instances[:green], 5],
  [:san_francisco, :salt_lake, route_type_instances[:white], 5],
  [:salt_lake, :denver, route_type_instances[:red], 3],
  [:salt_lake, :denver, route_type_instances[:yellow], 3],
  [:denver, :omaha, route_type_instances[:purple], 4],
  [:omaha, :kansas, route_type_instances[:grey], 1, 2],
  [:omaha, :chicago, route_type_instances[:blue], 4],
  [:denver, :kansas, route_type_instances[:black], 4],
  [:denver, :kansas, route_type_instances[:orange], 4],
  [:kansas, :saint_louis, route_type_instances[:blue], 2],
  [:kansas, :saint_louis, route_type_instances[:purple], 2],
  [:saint_louis, :nashville, route_type_instances[:grey], 2],
  [:nashville, :raleigh, route_type_instances[:black], 3],
  [:raleigh, :charleston, route_type_instances[:grey], 2],
  [:raleigh, :alanta, route_type_instances[:grey], 2],
  [:toronto, :chicago, route_type_instances[:white], 4],
  [:salt_lake, :las_vegas, route_type_instances[:orange], 3],
  [:denver, :phoenix, route_type_instances[:white], 5],
  [:denver, :santa_fe, route_type_instances[:grey], 2],
  [:denver, :oklahoma, route_type_instances[:red], 4],
  [:kansas, :oklahoma, route_type_instances[:grey], 2, 2],
  [:saint_louis, :little_rock, route_type_instances[:grey], 2],
  [:nashville, :little_rock, route_type_instances[:white], 3],
  [:nashville, :alanta, route_type_instances[:grey], 1],
  [:alanta, :charleston, route_type_instances[:grey], 2],
  [:oklahoma, :little_rock, route_type_instances[:grey], 2],
  [:san_francisco, :los_angeles, route_type_instances[:yellow], 3],
  [:san_francisco, :los_angeles, route_type_instances[:purple], 3],
  [:las_vegas, :los_angeles, route_type_instances[:grey], 2],
  [:raleigh, :alanta, route_type_instances[:grey], 2, 2],
  [:los_angeles, :phoenix, route_type_instances[:grey], 3],
  [:phoenix, :santa_fe, route_type_instances[:grey], 3],
  [:phoenix, :el_paso, route_type_instances[:grey], 3],
  [:santa_fe, :el_paso, route_type_instances[:grey], 2],
  [:santa_fe, :oklahoma, route_type_instances[:blue], 3],
  [:el_paso, :oklahoma, route_type_instances[:yellow], 5],
  [:oklahoma, :dallas, route_type_instances[:grey], 2, 2],
  [:little_rock, :dallas, route_type_instances[:grey], 2],
  [:little_rock, :new_orleans, route_type_instances[:green], 3],
  [:alanta, :new_orleans, route_type_instances[:yellow], 4],
  [:alanta, :new_orleans, route_type_instances[:orange], 4],
  [:alanta, :miami, route_type_instances[:blue], 5],
  [:charleston, :miami, route_type_instances[:purple], 4],
  [:new_orleans, :miami, route_type_instances[:red], 6],
  [:new_orleans, :houston, route_type_instances[:grey], 2],
  [:dallas, :houston, route_type_instances[:grey], 1, 2],
  [:el_paso, :dallas, route_type_instances[:red], 4],
  [:el_paso, :houston, route_type_instances[:green], 6],
  [:los_angeles, :el_paso, route_type_instances[:black], 6]
]

# Setup routes between cities.
unique_route_instances = route_details.map do |route_details|
  city1 = city_instances[route_details[0]]
  city2 = city_instances[route_details[1]]
  route_type = route_details[2]
  pieces = route_details[3]
  repeat = route_details.length > 4 ? route_details[4] : 1

  if (city1.id > city2.id)
    temp_city = city1
    city1 = city2
    city2 = temp_city
  end

  indexes = *(0...repeat)
  indexes.map do
    Route.create!(city1: city1, city2: city2, pieces: pieces, route_type: route_type)
  end
end

route_instances = unique_route_instances.flatten

# TODO: Setup a reduced set of routes for testing.
