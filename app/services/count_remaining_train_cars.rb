class CountRemainingTrainCars
  def initialize(train_car_type:, game:)
    @train_car_type = train_car_type
    @game = game
  end

  def call
    dealt_train_cars_of_type = Game.joins(:dealt_train_cars).where(dealt_train_cars: {train_car_type: @train_car_type})
    @train_car_type.total - dealt_train_cars_of_type.length
  end
end
