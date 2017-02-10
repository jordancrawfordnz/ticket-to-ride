class FinishActionsController < ApplicationController
  FINISH_ACTION_FAILED_ERROR = "Could not finish actions."

  def create
    @game = Game.find(params.require(:game_id))

    finish_player_actions_result = FinishPlayerActions.new(game: @game).call
    if !finish_player_actions_result
      flash[:errors] = [FINISH_ACTION_FAILED_ERROR]
    end
    redirect_to @game
  end
end
