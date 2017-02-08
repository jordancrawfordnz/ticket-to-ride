class DrawTrainCarsController < ApplicationController
  DRAW_TRAIN_CARS_FAILED_ERROR = "Could not draw train cars."

  def create
    @game = Game.find(params.require(:game_id))
    @player = @game.current_player

    draw_train_cars_result = MakeDrawTrainCarsTurn.new(player: @player).call
    if !draw_train_cars_result
      flash[:errors] = [DRAW_TRAIN_CARS_FAILED_ERROR]
    end
    redirect_to @game
  end
end
