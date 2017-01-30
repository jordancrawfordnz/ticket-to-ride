def has_train_cars(count:)
  expect(page).to have_selector('.train-car', count: count)
end

def has_train_pieces(count:)
  expect(page).to have_selector('.train-piece-count', text: count)
end

def draw_train_cars
  click_button("Draw more cards")
end

def has_list_of_avaliable_routes(count:)
  expect(page).to have_selector('.avaliable-route', count: count)
end

def set_player_train_pieces(player:, pieces:)
  player.train_pieces = pieces
  player.save!
end
