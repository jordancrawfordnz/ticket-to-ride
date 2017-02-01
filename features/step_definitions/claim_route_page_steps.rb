Then(/^the player is on the claim route page$/) do
  expect(page).to have_css 'h1', text: 'Claim a route'
end

Then(/^the player sees a list of their train cars on the claim route page$/) do
  player = @game.current_player
  expect(page).to have_css '.train-car', count: player.dealt_train_cars.size
end

When(/^the player selects (\d+) "([^"]*)" train cars$/) do |count, train_car_type|
  train_cars_of_type = page.all(".train-car", text: train_car_type)
  count.to_i.times do |index|
    if train_cars_of_type[index]
      train_cars_of_type[index].find("input").set(true)
    end
  end
end
