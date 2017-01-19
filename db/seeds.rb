# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Setup the train car types.
[
  { name: "Locomotive", total: 14 },
  { name: "Box", total: 12 },
  { name: "Passenger", total: 12 },
  { name: "Tanker", total: 12 },
  { name: "Reefer", total: 12 },
  { name: "Freight", total: 12 },
  { name: "Hopper", total: 12 },
  { name: "Coal", total: 12 },
  { name: "Caboose", total: 12 }
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

# TODO: Setup a struct for the colours!
GRAY = 'Gray'
WHITE = 'White'
YELLOW = 'Yellow'
PINK = 'Pink'
GREEN = 'Green'
RED = 'Red'
ORANGE = 'Orange'
BLUE = 'Blue'
BLUE_GRAY = 'Blue-gray'

# Setup routes between cities.
route_details = [
  [:vancouver, :calgary, GRAY, 3],
  [:vancouver, :seattle, GRAY, 1, 2],
  [:calgary, :seattle, GRAY, 4],
  [:calgary, :helena, GRAY, 4],
  [:calgary, :winnipeg, WHITE, 6],
  [:helena, :seattle, YELLOW, 6],
  [:helena, :salt_lake, PINK, 3],
  [:helena, :denver, GREEN, 4],
  [:helena, :omaha, RED, 5],
  [:helena, :deluth, ORANGE, 6],
  [:helena, :winnipeg, BLUE, 4],
  [:winnipeg, :sault_st_marie, GRAY, 6],
  [:winnipeg, :deluth, BLUE_GRAY, 4],
  [:deluth, :omaha, GRAY, 2, 2],
  [:deluth, :chicago, RED, 3],
  [:deluth, :toronto, PINK, 6],
  [:deluth, :sault_st_marie, GRAY, 3],
  [:sault_st_marie, :montreal, BLUE_GRAY, 5],
  [:sault_st_marie, :toronto, GRAY, 2],
  [:montreal, :toronto, GRAY, 3],
  [:montreal, :new_york, BLUE, 3],
  [:montreal, :boston, GRAY, 2, 2],
  [:boston, :new_york, YELLOW, 2],
  [:boston, :new_york, RED, 2],
  [:toronto, :pittsburgh, GRAY, 2],
  [:new_york, :washington, ORANGE, 2],
  [:new_york, :washington, BLUE_GRAY, 2],
  [:new_york, :pittsburgh, WHITE, 2],
  [:new_york, :pittsburgh, GREEN, 2],
  [:pittsburgh, :washington, GRAY, 2],
  [:pittsburgh, :raleigh, GRAY, 2],
  [:pittsburgh, :nashville, YELLOW, 4],
  [:pittsburgh, :saint_louis, GREEN, 5],
  [:chicago, :pittsburgh, ORANGE, 3],
  [:chicago, :pittsburgh, BLUE_GRAY, 3],
  [:chicago, :saint_louis, GREEN, 2],
  [:chicago, :saint_louis, WHITE, 2],
  [:washington, :raleigh, GRAY, 2, 2],
  [:seattle, :portland, GRAY, 1, 2],
  [:portland, :salt_lake, BLUE, 6],
  [:portland, :san_francisco, GREEN, 5],
  [:portland, :san_francisco, PINK, 5],
  [:san_francisco, :salt_lake, GREEN, 5],
  [:san_francisco, :salt_lake, WHITE, 5],
  [:salt_lake, :denver, RED, 3],
  [:salt_lake, :denver, YELLOW, 3],
  [:denver, :omaha, PINK, 4],
  [:omaha, :kansas, GRAY, 1, 2],
  [:omaha, :chicago, BLUE, 4],
  [:denver, :kansas, BLUE_GRAY, 4],
  [:denver, :kansas, ORANGE, 4],
  [:kansas, :saint_louis, BLUE, 2],
  [:kansas, :saint_louis, PINK, 2],
  [:saint_louis, :nashville, GRAY, 2],
  [:nashville, :raleigh, BLUE_GRAY, 3],
  [:raleigh, :charleston, GRAY, 2],
  [:raleigh, :alanta, GRAY, 2],
  [:toronto, :chicago, WHITE, 4],
  [:salt_lake, :las_vegas, ORANGE, 3],
  [:denver, :phoenix, WHITE, 5],
  [:denver, :santa_fe, GRAY, 2],
  [:denver, :oklahoma, RED, 4],
  [:kansas, :oklahoma, GRAY, 2, 2],
  [:saint_louis, :little_rock, GRAY, 2],
  [:nashville, :little_rock, WHITE, 3],
  [:nashville, :alanta, GRAY, 1],
  [:alanta, :charleston, GRAY, 2],
  [:oklahoma, :little_rock, GRAY, 2],
  [:san_francisco, :los_angeles, YELLOW, 3],
  [:san_francisco, :los_angeles, PINK, 3],
  [:las_vegas, :los_angeles, GRAY, 2],
  [:raleigh, :alanta, GRAY, 2, 2],
  [:los_angeles, :phoenix, GRAY, 3],
  [:phoenix, :santa_fe, GRAY, 3],
  [:phoenix, :el_paso, GRAY, 3],
  [:santa_fe, :el_paso, GRAY, 2],
  [:santa_fe, :oklahoma, BLUE, 3],
  [:el_paso, :oklahoma, YELLOW, 5],
  [:oklahoma, :dallas, GRAY, 2, 2],
  [:little_rock, :dallas, GRAY, 2],
  [:little_rock, :new_orleans, GREEN, 3],
  [:alanta, :new_orleans, YELLOW, 4],
  [:alanta, :new_orleans, ORANGE, 4],
  [:alanta, :miami, BLUE, 5],
  [:charleston, :miami, PINK, 4],
  [:new_orleans, :miami, RED, 6],
  [:new_orleans, :houston, GRAY, 2],
  [:dallas, :houston, GRAY, 1, 2],
  [:el_paso, :dallas, RED, 4],
  [:el_paso, :houston, GREEN, 6],
  [:los_angeles, :el_paso, BLUE_GRAY, 6]
]

# Setup routes between cities.
unique_route_instances = route_details.map do |route_details|
  city1 = city_instances[route_details[0]]
  city2 = city_instances[route_details[1]]
  colour = route_details[2]
  pieces = route_details[3]
  repeat = route_details.length > 4 ? route_details[4] : 1

  if (city1.id > city2.id)
    temp_city = city1
    city1 = city2
    city2 = temp_city
  end

  indexes = *(0...repeat)
  indexes.map do
    Route.create!(city1: city1, city2: city2, pieces: pieces)
  end
end

route_instances = unique_route_instances.flatten

# TODO: Setup a reduced set of routes for testing.
