class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params.require(:id))
    @player = @game.current_player

    @all_city_destinations = FetchAllCityDestinations.new(game: @game).call
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

  def board
    @game = Game.find(params.require(:id))

    board = Route.all.map do |route|
      board_display = {
        svgId: route.svg_id,
        routeId: route.id
      }

      route_claim = route.claimed_route_for_game(@game)
      board_display['isFilled'] = route_claim.present?
      board_display['canClick'] = !@game.finished_action && !route_claim.present?

      if route_claim.present?
        board_display['displayColour'] = route_claim.player.colour
      end

      board_display
    end

    respond_to do |format|
      format.json { render :json => board }
    end
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
