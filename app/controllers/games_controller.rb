class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
    @player_count = 5
  end

  def edit
  end

  def create
    setup_game = SetupGame.new(player_details: player_params)
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

  private

  def game_params
    params.fetch(:game, {})
  end

  def player_params
    game_params["players"].symbolize_keys
  end
end
