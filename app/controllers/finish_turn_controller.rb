class FinishTurnController < ApplicationController
  FINISH_TURN_FAILED_ERROR = "Could not finish turn."

  def create
    @game = Game.find(params.require(:game_id))

    finish_turn_result = FinishTurn.new(game: @game).call
    if !finish_turn_result
      flash[:errors] = [FINISH_TURN_FAILED_ERROR]
    end
    redirect_to @game
  end
end
