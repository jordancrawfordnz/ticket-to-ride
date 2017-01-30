When(/^the player sees (\d+) train cars$/) do |train_car_count|
  expect(page).to have_selector('.train-car', count: train_car_count)
end

When(/^the player sees they have (\d+) train pieces$/) do |expected_train_pieces|
  expect(page).to have_selector('.train-piece-count', text: expected_train_pieces)
end

When(/^the player uses their turn to draw additional train cars$/) do
  click_button("Draw more cards")
end

Then(/^the player sees the destinations from each city listed$/) do
  expect(page).to have_selector('.available-route', count: Route.count * 2)
end

Given(/^the player has (\d+) train pieces$/) do |train_pieces|
  @player.train_pieces = train_pieces
  @player.save!
end
