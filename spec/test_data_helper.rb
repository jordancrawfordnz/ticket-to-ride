def player_colours
  ["Yellow", "Black", "Blue", "Green", "Red"]
end

def test_players
  players = []
  5.times.each do |player_index|
    player = Player.new(name: "Player #{player_index + 1}", colour: player_colours[player_index], train_pieces: 45)
    players.push(player)
  end
  players
end
