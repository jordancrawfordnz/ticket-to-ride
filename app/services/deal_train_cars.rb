class DealTrainCars
  def initialize(player:, amount_to_deal:)
    @player = player
    @amount_to_deal = amount_to_deal
  end

  def call
    if remaining_train_car_deck.length - @amount_to_deal < 0
      return false
    end

    dealt_cards = []
    DealtTrainCar.transaction do
      @amount_to_deal.times do
        train_car_type = remaining_train_car_deck.sample
        dealt_cards.push(DealtTrainCar.create(player: @player, train_car_type: train_car_type))
      end
    end

    dealt_cards
  end

  private

  def remaining_train_car_deck
    deck = []
    TrainCarType.order(:name).each do |train_car_type|
      remaining_train_car_count = CountRemainingTrainCars.new(game: @player.game, train_car_type: train_car_type).call
      remaining_train_car_count.times do
        deck.push(train_car_type)
      end
    end
    deck
  end
end
