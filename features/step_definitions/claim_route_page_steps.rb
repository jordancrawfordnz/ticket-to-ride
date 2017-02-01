Then(/^the player is on the claim route page$/) do
  expect(page).to have_css 'h1', text: 'Claim a route'
end

Then(/^the player sees a list of their train cars on the claim route page$/) do
  player = @game.current_player
  expect(page).to have_css '.train-car', count: player.dealt_train_cars.size
end
