class GamesController < ApplicationController
  DRAW_TRAIN_CARS_FAILED_ERROR = "Could not draw train cars."

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params.require(:id))
    @player = @game.current_player

    fields_to_include = [:route_type, :city1, :city2, :route_claim]
    @all_routes = City.all.includes(where_city_1: fields_to_include, where_city_2: fields_to_include).map do |city|
      city_details = {}
      city_details[:name] = city.name
      destination_routes = city.where_city_1 + city.where_city_2
      city_details[:destinations] = destination_routes.map do |destination_route|
        destination = {}
        destination[:name] = destination_route.alternate_city(city).name
        destination[:pieces] = destination_route.pieces
        destination[:route_id] = destination_route.id
        destination[:route_colour] = destination_route.route_type.colour
        destination[:is_claimed?] = destination_route.route_claim.present?
        if destination[:is_claimed?]
          destination[:claimed_player] = destination_route.route_claim.player
        end
        destination
      end
      city_details
    end
  end

  def new
    @game = Game.new
    @player_count = 5
  end

  def create
    setup_game = SetupGame.new(player_details: player_details)

    if setup_game.call
      redirect_to setup_game.game
    elsif
      flash[:errors] = setup_game.errors
      redirect_to :new_game
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  # TODO: Move this to a controller of its own (but under the same URL)
  # TODO: Could generalise this a bit more, e.g.: action.
    # Maybe this belongs somewhere else, something to do with turns perhaps.
  def draw_train_cars
    @game = Game.find(params.require(:id))
    @player = @game.current_player

    draw_train_cars_result = MakeDrawTrainCarsTurn.new(player: @player).call
    if !draw_train_cars_result
      flash[:errors] = [DRAW_TRAIN_CARS_FAILED_ERROR]
    end
    redirect_to @game
  end

  private

  def clean_player_detail(player_detail)
    player_detail.transform_keys do |detail_key|
      detail_key.to_sym
    end
  end

  def player_details
    player_params = params.fetch(:game)['players'].to_unsafe_h # TODO: Any way to do this safely?
    player_params.transform_values { |player_detail| clean_player_detail(player_detail) }
  end
end
