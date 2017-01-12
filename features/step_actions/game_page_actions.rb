def has_train_cars(count:)
  expect(page).to have_selector('.train-car', count: count)
end
