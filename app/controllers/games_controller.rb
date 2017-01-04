class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    # TODO: Include Players. Use a SetupGame service.
    @game = Game.new(game_params)

    # respond_to do |format|
    #   if @game.save
    #     format.html { redirect_to @game, notice: 'Game was successfully created.' }
    #     format.json { render :show, status: :created, location: @game }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @game.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    def game_params
      params.fetch(:game, {})
    end
end
