require 'rails_helper'

describe RouteClaim do
  let(:city1) { City.new({ name: "City 1" })}
  let(:city2) { City.new({ name: "City 2" })}
  let(:route_type) { RouteType.new({ colour: "Green" }) }
  let(:route) { Route.new(city1: city1, city2: city2, pieces: 5, route_type: route_type) }

  let(:game) { Game.new }
  let(:player) { Player.new(name: "Player 1", colour: "Green", game: game, train_pieces: 30) }

  let(:parameters) { { route: route, player: player } }
  let(:route_claim) { RouteClaim.new(parameters) }

  describe "on initialize" do
    context "with valid params" do
      it "is valid" do
        expect(route_claim).to be_valid
      end
    end

    shared_examples "RouteClaim is invalid" do
      it "is invalid" do
        expect(route_claim).not_to be_valid
      end
    end

    context "with no player" do
      let(:player) { nil }

      include_examples "RouteClaim is invalid"
    end

    context "with no route" do
      let(:route) { nil }

      include_examples "RouteClaim is invalid"
    end
  end
end
