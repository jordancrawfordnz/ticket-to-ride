class GamesController < ApplicationController
  DRAW_TRAIN_CARS_FAILED_ERROR = "Could not draw train cars."

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @player = @game.players.first
  end

  def new
    @game = Game.new
    @player_count = 5
  end

  def edit
  end

  def create
    setup_game = SetupGame.new(player_details: player_details)
    setup_game.call

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

  # TODO: Could generalise this a bit more, e.g.: action.
    # Maybe this belongs somewhere else, something to do with turns perhaps.
  def draw_train_cars
    @game = Game.find(params[:id])
    @player = @game.players.first

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
