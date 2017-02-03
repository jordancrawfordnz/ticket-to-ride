require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe ClaimRoute do
  let(:game) { Game.new }
  let(:player) do
    Player.new(
      game: game,
      name: "Player",
      colour: player_colours[0],
      train_pieces: player_pieces,
      dealt_train_cars: dealt_train_cars,
      score: 0
    )
  end

  let(:dealt_train_cars) do
    total_assigned_train_cars.times.map do
      DealtTrainCar.new(train_car_type: train_car_type)
    end
  end

  let(:player_alt) { test_players[1] }

  let(:total_assigned_train_cars) { 10 }
  let(:total_train_cars) { 5 }
  let(:player_pieces) { 45 }
  let(:route_pieces) { total_train_cars }

  let(:train_car_colour) { "Green" }
  let(:train_car_type) { TrainCarType.find_by(colour: train_car_colour) }
  let(:train_cars) do
    if player.present?
      player.dealt_train_cars.first(total_train_cars)
    end
  end

  let(:route_type_colour) { train_car_colour }
  let(:route_type_params) { { colour: route_type_colour } }
  let(:route_type) { RouteType.create!(route_type_params) }
  let(:route) { Route.new(city1: test_cities[0], city2: test_cities[1], pieces: route_pieces, route_type: route_type) }

  let(:parameters) { { player: player, train_cars: train_cars, route: route } }
  let(:claim_route) { ClaimRoute.new(parameters) }

  before do
    player.save! if player
  end

  describe "on initialisation" do
    shared_examples "raises error on initialise" do
      it "should raise an error" do
        expect { claim_route }.to raise_error(ArgumentError)
      end
    end

    context "with valid params" do
      it "should not raise an error" do
        expect { claim_route }.not_to raise_error
      end
    end

    context "with a nil player" do
      let(:player) { nil }

      include_examples "raises error on initialise"
    end

    context "with nil train cars" do
      let(:train_cars) { nil }

      include_examples "raises error on initialise"
    end

    context "with a nil route" do
      let(:route) { nil }

      include_examples "raises error on initialise"
    end
  end

  shared_examples "returns false with error" do |expected_error_message|
    describe "#call" do
      it "returns false" do
        expect(claim_route.call).to be false
      end

      it "does not make any route claims" do
        expect { claim_route.call }.to_not change { RouteClaim.count }
      end

      it "does not change the players pieces" do
        expect { claim_route.call }.to_not change { player.train_pieces }
      end

      it "does not change the players train cars" do
        expect { claim_route.call }.to_not change { player.dealt_train_cars.length }
      end

      it "does not change the players score" do
        expect { claim_route.call }.not_to change { player.score }
      end
    end

    context "after trying to claim a route" do
      before { claim_route.call }

      it "has the error '#{expected_error_message}'" do
        expect(claim_route.errors).to include expected_error_message
      end
    end
  end

  context "with a train cars array of length 0" do
    let(:train_cars) { [] }

    include_examples "returns false with error", ClaimRoute::NO_TRAIN_CARS
  end

  context "with a train car that doesn't belong to the player" do
    before do
      player_alt.dealt_train_cars = total_assigned_train_cars.times.map do
        DealtTrainCar.new(train_car_type: train_car_type)
      end
    end

    let(:train_cars) { player_alt.dealt_train_cars.first(total_train_cars) }

    include_examples "returns false with error", ClaimRoute::TRAIN_CARS_DONT_BELONG_TO_PLAYER
  end

  context "with a too few train cars" do
    let(:route_pieces) { 5 }
    let(:total_train_cars) { route_pieces - 1 }

    include_examples "returns false with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED
  end

  context "with too many train cars" do
    let(:route_pieces) { 5 }
    let(:total_train_cars) { route_pieces + 1 }

    include_examples "returns false with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED
  end

  context "with a user with too few train pieces" do
    let(:player_pieces) { total_train_cars - 1 }

    include_examples "returns false with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_PIECES
  end

  context "when trying to claim a route that is already claimed" do
    before do
      RouteClaim.new(player: claim_player, route: route)
    end

    context "by another player" do
      let(:claim_player) { player_alt }

      include_examples "returns false with error", ClaimRoute::ROUTE_ALREADY_TAKEN
    end

    context "by the same player" do
      let(:claim_player) { player }

      include_examples "returns false with error", ClaimRoute::ROUTE_ALREADY_TAKEN
    end
  end

  shared_examples "returns true and actions the RouteClaim" do
    describe "#call" do
      it "returns true" do
        expect(claim_route.call).to be true
      end

      it "makes one route claim" do
        expect { claim_route.call }.to change { RouteClaim.count }.by(1)
      end

      it "reduces the player pieces by the route_pieces" do
        expect { claim_route.call }.to change { player.train_pieces }.by(-route_pieces)
      end

      it "reduces the number of DealtTrainCars by the route_pieces" do
        expect { claim_route.call }.to change { DealtTrainCar.count }.by(-route_pieces)
      end

      it "increases the players score" do
        expect { claim_route.call }.to change { player.score }.by(ClaimRoute::PIECES_TO_SCORE[route.pieces])
      end
    end

    context "after claiming a route" do
      before { claim_route.call }

      it "removes the nominated train cars to use from the players dealt train cars" do
        expect(player.dealt_train_cars.to_a).to eq (dealt_train_cars - train_cars)
      end
    end
  end

  context "when all the train cars are a different colour" do
    let(:route_type_colour) { "Red" }

    include_examples "returns false with error", ClaimRoute::WRONG_TRAIN_CAR_TYPE
  end

  context "with one train car different from the others" do
    let(:dealt_train_cars) do
      different_train_car = DealtTrainCar.new(train_car_type: different_train_car_type)
      normal_train_cars = (total_assigned_train_cars - 1).times.map do
        DealtTrainCar.new(train_car_type: train_car_type)
      end

      normal_train_cars.unshift(different_train_car)
    end

    context "with a different colour" do
      let(:different_train_car_type) { TrainCarType.find_by(colour: "Red") }

      include_examples "returns false with error", ClaimRoute::WRONG_TRAIN_CAR_TYPE
    end

    context "with a wildcard" do
      let(:different_train_car_type) { TrainCarType.find_by(name: "Locomotive") }

      include_examples "returns true and actions the RouteClaim"
    end
  end

  context "with a route that accecpts all train cars" do
    let(:route_type_params) { { colour: route_type_colour, accepts_all_train_cars: true  } }

    include_examples "returns true and actions the RouteClaim"
  end

  context "with valid parameters" do
    include_examples "returns true and actions the RouteClaim"
  end

  context "with a user who has exactly the correct amount of train pieces" do
    let(:player_pieces) { total_train_cars }

    include_examples "returns true and actions the RouteClaim"
  end
end
