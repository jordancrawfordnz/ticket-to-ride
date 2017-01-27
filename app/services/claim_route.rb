class ClaimRoute
  REQUIRED_PARAMETERS_NOT_PROVIDED = "A required parameter was not provided."
  NO_TRAIN_CARS = "No train cars were provided to use for the route."
  TRAIN_CARS_DONT_BELONG_TO_PLAYER = "Not all the provided train cars belong to the player."
  INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED = "Not enough train cars were provided."
  INCORRECT_NUMBER_OF_TRAIN_PIECES = "Player does not have enough train pieces."
  ROUTE_ALREADY_TAKEN = "The route has already been taken."

  attr_reader :errors

  def initialize(player:, train_cars:, route:)
    if player.nil? || train_cars.nil? || route.nil?
      raise ArgumentError.new(REQUIRED_PARAMETERS_NOT_PROVIDED)
    end

    @player = player
    @train_cars = train_cars
    @route = route
    @errors = []
  end

  def call
    check_params
    if @errors.any?
      return false
    end

    @player.with_lock do
      RouteClaim.create!(route: @route, player: @player)
      @player.train_pieces -= @route.pieces
      @player.dealt_train_cars -= @train_cars
      @player.save!
    end

    @errors.none?
  end

  private

  def check_params
    error = if @train_cars.length < 1
      NO_TRAIN_CARS
    elsif @route.route_claim.present?
      ROUTE_ALREADY_TAKEN
    elsif @train_cars.length != @route.pieces
      INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED
    elsif @player.train_pieces < @route.pieces
      INCORRECT_NUMBER_OF_TRAIN_PIECES
    elsif !@train_cars.all? { |train_car| @player.dealt_train_cars.include?(train_car) }
      TRAIN_CARS_DONT_BELONG_TO_PLAYER
    end
    @errors.push(error)
  end
end
