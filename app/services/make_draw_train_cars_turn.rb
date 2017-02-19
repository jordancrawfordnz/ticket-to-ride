class MakeDrawTrainCarsTurn
  TURN_DRAW_AMOUNT = 2

  def initialize(player:)
    @player = player
  end

  def call
    if @player.game.finished_action
      return false
    end

    deal_result = DealTrainCars.new(player: @player, amount_to_deal: TURN_DRAW_AMOUNT).call
    if deal_result
      FinishPlayerActions.new(game: @player.game).call
    else
      false
    end
  end
end
