class Destination
  def initialize(route:, city:)
    @route = route
    @city = city
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
    @route.route_claim.player if @route.route_claim
  end
end
