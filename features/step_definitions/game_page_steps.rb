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
  expect(page).to have_selector('.destination', count: Route.count * 2)
end

Given(/^the player has (\d+) train pieces$/) do |train_pieces|
  if @game.nil?
    puts "game is nil!"
  end
  player = @game.current_player
  player.train_pieces = train_pieces
  player.save!
end

Given(/^the player has (\d+) "([^"]*)" train cars$/) do |count, card_type|
  if @game.nil?
    puts "game is nil!"
  end
  player = @game.current_player
  type = TrainCarType.find_by(name: card_type)
  player.dealt_train_cars.clear
  count.to_i.times do
    player.dealt_train_cars.push(DealtTrainCar.new(train_car_type: type))
  end
  player.save!
end

When(/^the player clicks the claim route button on a route between "([^"]*)" and "([^"]*)"$/) do |city1_name, city2_name|
  find_game_page_destination(city1_name, city2_name).click_button("Claim Route")
end

Then(/^the player sees the route from "([^"]*)" to "([^"]*)" claimed with their name$/) do |city1_name, city2_name|
  player = @game.current_player
  destination = find_game_page_destination(city1_name, city2_name)
  expect(destination).to have_content "Claimed by #{player.name}"
end

Then(/^the player sees their score on the page$/) do
  player = @game.current_player
  expect(page).to have_content "Score: #{player.score}"
end
