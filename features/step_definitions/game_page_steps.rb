When(/^the user sees (\d+) train cars$/) do |train_car_count|
  has_train_cars(count: train_car_count)
end
