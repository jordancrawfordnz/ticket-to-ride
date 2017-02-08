class MakeDrawTrainCarsTurn
  TURN_DRAW_AMOUNT = 2

  def initialize(player:)
    @player = player
  end

  def call
    deal_result = DealTrainCars.new(player: @player, amount_to_deal: TURN_DRAW_AMOUNT).call
    if deal_result
      FinishTurn.new(game: @player.game).call
    else
      false
    end
  end
end
