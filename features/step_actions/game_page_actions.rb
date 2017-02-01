def player_claims_route
  player = @game.current_player
  city1 = City.find_by({ name: city1_name })
  city2 = City.find_by({ name: city2_name })
  route = Route.find_by({ city1: city1, city2: city2 })
  RouteClaim.create!(route: route, player: player)
end

def find_game_page_destination(city1_name, city2_name)
  route_element = find('.route strong', text: city1_name).find(:xpath, '..')
  destination = route_element.find('.destination', text: "Calgary")
end
