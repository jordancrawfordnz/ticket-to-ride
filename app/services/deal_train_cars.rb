class DealTrainCars
  def initialize(player:, amount_to_deal:)
    @player = player
    @amount_to_deal = amount_to_deal
  end

  def call
    DealtTrainCar.transaction do
      deck = remaining_train_car_deck
      if deck.length < @amount_to_deal
        return false
      else
        build_train_car_types = deck.shuffle.take(@amount_to_deal)
        build_train_car_types.map do |train_car_type|
          DealtTrainCar.create!(player: @player, train_car_type: train_car_type)
        end
      end
    end
  end

  private

  def remaining_train_car_deck
    TrainCarType.order(:name).each.with_object([]) do |train_car_type, deck|
      remaining_train_car_count = CountRemainingTrainCars.new(game: @player.game, train_car_type: train_car_type).call
      remaining_train_car_count.times do
        deck.push(train_car_type)
      end
    end
  end
end
