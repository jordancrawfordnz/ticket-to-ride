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

COLOURS ||= {
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

route_types = {
                grey: { accepts_all_train_cars: true },
                white: nil,
                yellow: nil,
                purple: nil,
                green: nil,
                red: nil,
                orange: nil,
                blue: nil,
                black: nil
              }

route_type_instances = route_types.each.with_object({}) do |(colour_key, type_params), route_type_instances|
  route_params = { colour: COLOURS[colour_key] }
  route_params.merge!(type_params) if type_params
  route_type_instances[colour_key] = RouteType.create!(route_params)
end

# Setup routes between cities.
route_details = [
  [:vancouver, :calgary, route_type_instances[:grey], 118, 3],
  [:vancouver, :seattle, route_type_instances[:grey], [50, 51], 1, 2],
  [:calgary, :seattle, route_type_instances[:grey], 124, 4],
  [:calgary, :helena, route_type_instances[:grey], 126, 4],
  [:calgary, :winnipeg, route_type_instances[:white], 136, 6],
  [:helena, :seattle, route_type_instances[:yellow], 72, 6],
  [:helena, :salt_lake, route_type_instances[:purple], 76, 3],
  [:helena, :denver, route_type_instances[:green], 80, 4],
  [:helena, :omaha, route_type_instances[:red], 84, 5],
  [:helena, :deluth, route_type_instances[:orange], 74, 6],
  [:helena, :winnipeg, route_type_instances[:blue], 142, 4],
  [:winnipeg, :sault_st_marie, route_type_instances[:grey], 146, 6],
  [:winnipeg, :deluth, route_type_instances[:black], 144, 4],
  [:deluth, :omaha, route_type_instances[:grey], [92, 94], 2, 2],
  [:deluth, :chicago, route_type_instances[:red], 96, 3],
  [:deluth, :toronto, route_type_instances[:purple], 98, 6],
  [:deluth, :sault_st_marie, route_type_instances[:grey], 100, 3],
  [:sault_st_marie, :montreal, route_type_instances[:black], 150, 5],
  [:sault_st_marie, :toronto, route_type_instances[:grey], 106, 2],
  [:montreal, :toronto, route_type_instances[:grey], 108, 3],
  [:montreal, :new_york, route_type_instances[:blue], 110, 3],
  [:montreal, :boston, route_type_instances[:grey], [165, 162], 2, 2],
  [:boston, :new_york, route_type_instances[:yellow], 166, 2],
  [:boston, :new_york, route_type_instances[:red], 167, 2],
  [:toronto, :pittsburgh, route_type_instances[:grey], 104, 2],
  [:new_york, :washington, route_type_instances[:orange], 168, 2],
  [:new_york, :washington, route_type_instances[:black], 169, 2],
  [:new_york, :pittsburgh, route_type_instances[:white], 170, 2],
  [:new_york, :pittsburgh, route_type_instances[:green], 171, 2],
  [:pittsburgh, :washington, route_type_instances[:grey], 177, 2],
  [:pittsburgh, :raleigh, route_type_instances[:grey], 212, 2],
  [:pittsburgh, :nashville, route_type_instances[:yellow], 251, 4],
  [:pittsburgh, :saint_louis, route_type_instances[:green], 216, 5],
  [:chicago, :pittsburgh, route_type_instances[:orange], 172, 3],
  [:chicago, :pittsburgh, route_type_instances[:black], 174, 3],
  [:chicago, :saint_louis, route_type_instances[:green], 196, 2],
  [:chicago, :saint_louis, route_type_instances[:white], 197, 2],
  [:washington, :raleigh, route_type_instances[:grey], [178, 179], 2, 2],
  [:seattle, :portland, route_type_instances[:grey], [66, 70], 1, 2],
  [:portland, :salt_lake, route_type_instances[:blue], 58, 6],
  [:portland, :san_francisco, route_type_instances[:green], 114, 5],
  [:portland, :san_francisco, route_type_instances[:purple], 112, 5],
  [:san_francisco, :salt_lake, route_type_instances[:green], 205, 5],
  [:san_francisco, :salt_lake, route_type_instances[:white], 206, 5],
  [:salt_lake, :denver, route_type_instances[:red], 204, 3],
  [:salt_lake, :denver, route_type_instances[:yellow], 208, 3],
  [:denver, :omaha, route_type_instances[:purple], 86, 4],
  [:omaha, :kansas, route_type_instances[:grey], [217, 218], 1, 2],
  [:omaha, :chicago, route_type_instances[:blue], 249, 4],
  [:denver, :kansas, route_type_instances[:black], 235, 4],
  [:denver, :kansas, route_type_instances[:orange], 245, 4],
  [:kansas, :saint_louis, route_type_instances[:blue], 194, 2],
  [:kansas, :saint_louis, route_type_instances[:purple], 195, 2],
  [:saint_louis, :nashville, route_type_instances[:grey], 193, 2],
  [:nashville, :raleigh, route_type_instances[:black], 253, 3],
  [:raleigh, :charleston, route_type_instances[:grey], 255, 2],
  [:raleigh, :alanta, route_type_instances[:grey], [180, 183], 2, 2],
  [:toronto, :chicago, route_type_instances[:white], 102, 4],
  [:salt_lake, :las_vegas, route_type_instances[:orange], 221, 3],
  [:denver, :phoenix, route_type_instances[:white], 223, 5],
  [:denver, :santa_fe, route_type_instances[:grey], 209, 2],
  [:denver, :oklahoma, route_type_instances[:red], 247, 4],
  [:kansas, :oklahoma, route_type_instances[:grey], [186, 185], 2, 2],
  [:saint_louis, :little_rock, route_type_instances[:grey], 184, 2],
  [:nashville, :little_rock, route_type_instances[:white], 265, 3],
  [:nashville, :alanta, route_type_instances[:grey], 2, 1],
  [:alanta, :charleston, route_type_instances[:grey], 191, 2],
  [:oklahoma, :little_rock, route_type_instances[:grey], 190, 2],
  [:san_francisco, :los_angeles, route_type_instances[:yellow], 175, 3],
  [:san_francisco, :los_angeles, route_type_instances[:purple], 281, 3],
  [:las_vegas, :los_angeles, route_type_instances[:grey], 283, 2],
  [:los_angeles, :phoenix, route_type_instances[:grey], 295, 3],
  [:phoenix, :santa_fe, route_type_instances[:grey], 199, 3],
  [:phoenix, :el_paso, route_type_instances[:grey], 200, 3],
  [:santa_fe, :el_paso, route_type_instances[:grey], 210, 2],
  [:santa_fe, :oklahoma, route_type_instances[:blue], 209, 3],
  [:el_paso, :oklahoma, route_type_instances[:yellow], 295, 5],
  [:oklahoma, :dallas, route_type_instances[:grey], [189, 188], 2, 2],
  [:little_rock, :dallas, route_type_instances[:grey], 187, 2],
  [:little_rock, :new_orleans, route_type_instances[:green], 211, 3],
  [:alanta, :new_orleans, route_type_instances[:yellow], 267, 4],
  [:alanta, :new_orleans, route_type_instances[:orange], 273, 4],
  [:alanta, :miami, route_type_instances[:blue], 213, 5],
  [:charleston, :miami, route_type_instances[:purple], 263, 4],
  [:new_orleans, :miami, route_type_instances[:red], 291, 6],
  [:new_orleans, :houston, route_type_instances[:grey], 192, 2],
  [:dallas, :houston, route_type_instances[:grey], [297, 300], 1, 2],
  [:el_paso, :dallas, route_type_instances[:red], 201, 4],
  [:el_paso, :houston, route_type_instances[:green], 289, 6],
  [:los_angeles, :el_paso, route_type_instances[:black], 287, 6]
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
