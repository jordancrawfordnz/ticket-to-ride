When(/^the user inputs details about (\d+) players$/) do |player_count|
  set_player_details(limit: player_count.to_i)
end

When(/^the user fills in details about (\d+) players and (\d+) without a player name$/) do |complete_player_count, without_name_count|
  complete_player_count = complete_player_count.to_i
  set_player_details(limit: complete_player_count)
  without_name_count.to_i.times do |player_without_name_index|
    set_player_colour(player_without_name_index + complete_player_count)
  end
end

Given(/^the player navigates to the game page$/) do
  visit("/games/#{@game.id}")
end

Then(/^the player is on (?:the|a) game page$/) do
  expect(page.title).to eq "Game | Ticket to Ride"
end

When(/^a game with (\d+) players is setup$/) do |player_count|
  player_details = player_count.to_i.times.with_object({}) do |player_index, players|
    players["player#{player_index}"] = {
      name: player_name(player_index),
      colour: player_colour(player_index)
    }
  end

  setup_game = SetupGame.new(player_details: player_details)
  expect(setup_game.call).to be_truthy
  @game = setup_game.game
end

Given(/^there are (\d+) train cars in the deck$/) do |remaining_train_cars|
  TrainCarType.destroy_all
  TrainCarType.create!(name: "Test Train Car", total: remaining_train_cars  )
end
