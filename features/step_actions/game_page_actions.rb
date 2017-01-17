def has_train_cars(count:)
  expect(page).to have_selector('.train-car', count: count)
end

def has_train_pieces(count:)
  expect(page).to have_selector('.train-piece-count', text: count)
end

def draw_train_cars
  click_button("Draw more cards")
end
