class DealTrainCars
  def initialize(player:, amount_to_deal:)
    @player = player
    @amount_to_deal = amount_to_deal
  end

  def call
    dealt_cards = []
    DealtTrainCar.transaction do
      @amount_to_deal.times do
        dealt_cards.push(DealtTrainCar.create(player: @player, train_car_type: train_car_type_from_deck))
      end
    end
    dealt_cards
  end

  private

  def train_car_type_from_deck
    deck = []
    TrainCarType.order(:name).each do |train_car_type|
      remaining_train_car_count = CountRemainingTrainCars.new(game: @player.game, train_car_type: train_car_type).call
      remaining_train_car_count.times do
        deck.push(train_car_type)
      end
    end

    deck.sample
  end
end
