class Destination
  def initialize(route:, city:, game:)
    @route = route
    @city = city
    @game = game
  end

  def name
    @route.alternate_city(@city).name
  end

  def route
    @route
  end

  def colour
    @route.route_type.colour
  end

  def pieces
    @route.pieces
  end

  def claimed?
    claimed_player.present?
  end

  def claimed_player
    claimed_route =  @route.claimed_route_for_game(@game)
    claimed_route.player if claimed_route
  end
end
