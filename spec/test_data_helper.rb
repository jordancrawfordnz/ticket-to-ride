def player_colours
  ["Yellow", "Black", "Blue", "Green", "Red"]
end

def test_players
  5.times.map do |player_index|
    Player.new(name: "Player #{player_index + 1}", colour: player_colours[player_index], train_pieces: 45, score: 0)
  end
end

def assign_train_cars(count:, player:, type: "Box")
  type = TrainCarType.find_by(name: type)
  count.times.map do
    DealtTrainCar.create!(train_car_type: type, player: player)
  end
end

def test_game
  Game.create!(players: test_players, current_player: test_players.first)
end

def test_cities
  5.times.map do |city_index|
    City.new(name: "City #{city_index + 1}")
  end
end

def test_route_type
  RouteType.new(colour: "Green")
end

def test_route
  Route.new(city1: saved(test_cities[0]), city2: saved(test_cities[1]), pieces: 5, route_type: test_route_type)
end

def saved(to_save)
  to_save.save!
  to_save
end
