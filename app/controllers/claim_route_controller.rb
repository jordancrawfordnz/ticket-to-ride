class ClaimRouteController < ApplicationController
  ERROR_PREFIX = "Claim route: "

  def new
    @route = route_param
    @game = game_param
    @player = @game.current_player
  end

  def create
    game = game_param

    service = ClaimRoute.new(player: game.current_player, train_cars: dealt_train_cars, route: route_param)
    if !service.call
      flash[:errors] = service.errors.map { |error_message| "#{ERROR_PREFIX}#{error_message}" }
    end
    redirect_to game
  end

  private

  def game_param
    Game.find(params.require(:game_id))
  end

  def route_param
    Route.find(params.require(:route_id))
  end

  def dealt_train_cars
    train_car_ids = params[:dealt_train_car_ids] || []
    train_car_ids.map { |train_car_id| DealtTrainCar.find(train_car_id) }
  end
end
