class ClaimRoute
  REQUIRED_PARAMETERS_NOT_PROVIDED_MESSAGE = "A required parameter was not provided."
  NO_TRAIN_CARS_MESSAGE = "No train cars were provided to use for the route."
  TRAIN_CARS_DONT_BELONG_TO_PLAYER_MESSAGE = "Not all the provided train cars belong to the player."
  INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED_MESSAGE = "Not enough train cars were provided."
  INCORRECT_NUMBER_OF_TRAIN_PIECES_MESSAGE = "Player does not have enough train pieces."
  ROUTE_ALREADY_TAKEN_MESSAGE = "The route has already been taken."

  attr_reader :errors

  def initialize(player:, train_cars:, route:)
    if player.nil? || train_cars.nil? || route.nil?
      raise ArgumentError.new(REQUIRED_PARAMETERS_NOT_PROVIDED_MESSAGE)
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

    @player.transaction do
      RouteClaim.create!(route: @route, player: @player)
      @player.train_pieces -= @route.pieces
      @player.save!
    end

    @errors.none?
  end

  private

  def check_params
    if @train_cars.length < 1
      @errors.push(NO_TRAIN_CARS_MESSAGE)
    elsif !@route.route_claim.nil?
      @errors.push(ROUTE_ALREADY_TAKEN_MESSAGE)
    elsif @train_cars.length != @route.pieces
      @errors.push(INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED_MESSAGE)
    elsif @player.train_pieces < @route.pieces
      @errors.push(INCORRECT_NUMBER_OF_TRAIN_PIECES_MESSAGE)
    elsif !@train_cars.all? { |train_car| @player.dealt_train_cars.include?(train_car) }
      @errors.push(TRAIN_CARS_DONT_BELONG_TO_PLAYER_MESSAGE)
    end
  end
end
