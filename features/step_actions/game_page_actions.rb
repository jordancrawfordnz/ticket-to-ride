def player_claims_route
  player = @game.current_player
  city1 = City.find_by({ name: city1_name })
  city2 = City.find_by({ name: city2_name })
  route = Route.find_by({ city1: city1, city2: city2 })
  RouteClaim.create!(route: route, player: player)
end
