class CountRemainingTrainCars
  def initialize(game:, train_car_type:)
    @game = game
    @train_car_type = train_car_type
  end

  def call
    dealt_train_cars_of_type = Game.joins(:dealt_train_cars).where(train_car_type: @train_car_type)
    @train_car_type.total - dealt_train_cars_of_type.size
  end
end
