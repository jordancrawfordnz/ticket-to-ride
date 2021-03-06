def set_player_details(limit:)
  limit.times do |player_id|
    set_player_detail(player_id)
  end
end

def set_player_detail(player_id)
  set_player_name(player_id)
  set_player_colour(player_id)
end

def set_player_name(player_id)
  fill_in(id: "game_players_player_#{player_id}_name", with: player_name(player_id))
end

def player_name(player_id)
  "Player #{player_id}"
end

def player_colours
  ["Yellow", "Black", "Blue", "Green", "Red"]
end

def set_player_colour(player_id)
  select(player_colour(player_id), from: "game_players_player_#{player_id}_colour")
end

def player_colour(player_id)
  player_colours[player_id]
end
