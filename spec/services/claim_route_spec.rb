require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe ClaimRoute do
  let(:player) { Player.new(name: "Player", colour: player_colours[0], train_pieces: player_pieces) }
  let(:player_alt) { test_players[1] }

  let(:total_assigned_train_cars) { 10 }
  let(:total_train_cars) { 5 }
  let(:player_pieces) { 45 }
  let(:route_pieces) { total_train_cars }

  let(:train_car_type) { TrainCarType.find_by(name: "Box") }
  let(:train_cars) do
    if !player.nil?
      player.dealt_train_cars.first(total_train_cars)
    end
  end
  let(:route) { Route.new(city1: test_cities[0], city2: test_cities[1], pieces: route_pieces, route_type: test_route_type) }

  before do
    if !player.nil?
      total_assigned_train_cars.times do
        player.dealt_train_cars.push(DealtTrainCar.new(train_car_type: train_car_type))
      end
    end
  end

  let(:parameters) { { player: player, train_cars: train_cars, route: route } }
  let(:claim_route) { ClaimRoute.new(parameters) }

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

  shared_examples "ClaimRoute fails with error" do |expected_error_message|
    describe "#call" do
      it "returns false" do
        expect(claim_route.call).to be false
      end

      it "does not make any route claims" do
        expect { claim_route.call }.to change { RouteClaim.count }.by(0)
      end

      it "does not change the players pieces" do
        expect { claim_route.call }.to change { player.train_pieces }.by(0)
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

    include_examples "ClaimRoute fails with error", ClaimRoute::NO_TRAIN_CARS_MESSAGE
  end

  context "with a train car that doesn't belong to the player" do
    before do
      player_alt.dealt_train_cars = total_assigned_train_cars.times.map do
        DealtTrainCar.new(train_car_type: train_car_type)
      end
    end

    let(:train_cars) { player_alt.dealt_train_cars.first(total_train_cars) }

    include_examples "ClaimRoute fails with error", ClaimRoute::TRAIN_CARS_DONT_BELONG_TO_PLAYER_MESSAGE
  end

  context "with a too few train cars" do
    let(:route_pieces) { 5 }
    let(:total_train_cars) { route_pieces - 1 }

    include_examples "ClaimRoute fails with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED_MESSAGE
  end

  context "with too many train cars" do
    let(:route_pieces) { 5 }
    let(:total_train_cars) { route_pieces + 1 }

    include_examples "ClaimRoute fails with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_CARS_PROVIDED_MESSAGE
  end

  context "with a user with too few train pieces" do
    let(:player_pieces) { total_train_cars - 1 }

    include_examples "ClaimRoute fails with error", ClaimRoute::INCORRECT_NUMBER_OF_TRAIN_PIECES_MESSAGE
  end

  context "when trying to claim a route that is already claimed" do
    before do
      RouteClaim.new(player: claim_player, route: route)
    end

    context "by another player" do
      let(:claim_player) { player_alt }

      include_examples "ClaimRoute fails with error", ClaimRoute::ROUTE_ALREADY_TAKEN_MESSAGE
    end

    context "by the same player" do
      let(:claim_player) { player }

      include_examples "ClaimRoute fails with error", ClaimRoute::ROUTE_ALREADY_TAKEN_MESSAGE
    end
  end

  shared_examples "ClaimsRoute succeeds and actions the RouteClaim" do
    describe "#call" do
      it "returns true" do
        expect(claim_route.call).to be true
      end

      it "makes one route claim" do
        expect { claim_route.call }.to change { RouteClaims.count }.by(1)
      end

      it "reduces the player pieces by the route_pieces" do
        expect { claim_route.call }.to change { player.train_pieces }.by(-route_pieces)
      end
    end
  end

  context "with a user with the correct number of pieces, train cars and on an unclaimed route" do
    include_examples "ClaimsRoute succeeds and actions the RouteClaim"
  end

  context "with a user who has exactly the correct amount of train pieces" do
    let(:player_pieces) { total_train_cars }

    include_examples "ClaimsRoute succeeds and actions the RouteClaim"
  end
end
