When(/^the user sees (\d+) train cars$/) do |train_car_count|
  has_train_cars(count: train_car_count)
end

When(/^the user sees they have (\d+) train pieces$/) do |expected_train_pieces|
  has_train_pieces(count: expected_train_pieces)
end
