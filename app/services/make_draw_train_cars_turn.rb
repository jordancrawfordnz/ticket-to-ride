class MakeDrawTrainCarsTurn
  TURN_DRAW_AMOUNT = 2

  def initialize(player:)
    @player = player
  end

  def call
    deal_result = DealTrainCars.new(player: @player, amount_to_deal: TURN_DRAW_AMOUNT).call
    !!deal_result
  end
end
