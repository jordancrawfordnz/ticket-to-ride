class ClaimRoute
  REQUIRED_PARAMETERS_NOT_PROVIDED = "A required parameter was not provided."
  NO_TRAIN_CARS = "No train cars were provided to use for the route."
  TRAIN_CARS_DONT_BELONG_TO_PLAYER = "Not all the provided train cars belong to the player."
  INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED = "The incorrect number of train cars were provided."
  INCORRECT_NUMBER_OF_TRAIN_PIECES = "Player does not have enough train pieces."
  ROUTE_ALREADY_TAKEN = "The route has already been taken."
  WRONG_TRAIN_CAR_TYPE = "Not all the train cars are the correct type."
  PIECES_TO_SCORE = {
                      1 => 1,
                      2 => 2,
                      3 => 4,
                      5 => 10,
                      6 => 15
                    }

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
      @player.score += PIECES_TO_SCORE[@route.pieces]
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
    elsif !train_cars_correct_type?
      WRONG_TRAIN_CAR_TYPE
    end
    @errors.push(error)
  end

  def train_cars_correct_type?
    train_car_types = @train_cars.map { |train_car| train_car.train_car_type }
    non_wildcard_types = train_car_types.uniq.find_all { |train_car_type| !train_car_type.wildcard }
    if non_wildcard_types.none?
      return true
    elsif non_wildcard_types.one?
      route_type = @route.route_type
      train_car_type = non_wildcard_types.first
      route_type.colour == train_car_type.colour || route_type.accepts_all_train_cars
    else
      false
    end
  end
end
