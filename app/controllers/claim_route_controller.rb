class ClaimRouteController < ApplicationController
  def create
    @game = Game.find(params.require(:game_id))
    @player = @game.players.first
    @route = Route.find(params.require(:route_id))
    @dealt_train_cars = params.require(:dealt_train_car_ids).map { |train_car_id| DealtTrainCar.find(train_car_id) }

    service = ClaimRoute.new(player: @player, train_cars: @dealt_train_cars, route: @route)
    if !service.call
      flash[:errors] = service.errors
    end
    redirect_to @game
  end
end
