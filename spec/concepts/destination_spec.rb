require 'rails_helper'
require 'test_data_helper'

describe Destination do
  let(:city1) { City.new(name: "City 1") }
  let(:city2) { City.new(name: "City 2") }
  let(:route_type) { test_route_type }
  let(:pieces) { 3 }
  let(:route) { Route.new(city1: city1, city2: city2, route_type: test_route_type, pieces: pieces) }
  let(:current_city) { city1 }
  let(:game) { test_game }
  let(:destination) { Destination.new(route: route, city: city1, game: game) }

  before do
    city1.save!
    city2.save!
    route.save!
  end

  describe "#name" do
    it "is the city2 name" do
      expect(destination.name).to eq city2.name
    end
  end

  describe "#route" do
    it "is the provided route" do
      expect(destination.route).to eq route
    end
  end

  describe "#colour" do
    it "is the route's type's colour" do
      expect(destination.colour).to eq route_type.colour
    end
  end

  describe "#pieces" do
    it "is the route's pieces" do
      expect(destination.pieces).to eq route.pieces
    end
  end

  context "when a route is not claimed" do
    describe "#is_claimed?" do
      it "is false" do
        expect(destination).not_to be_claimed
      end
    end

    describe "#claimed_player" do
      it "is nil" do
        expect(destination.claimed_player).to be_nil
      end
    end
  end

  context "when a route is claimed" do
    let(:claim_player) { game.players.first }

    before do
      RouteClaim.create!(player: claim_player, route: route)
    end

    describe "#is_claimed?" do
      it "is true" do
        expect(destination).to be_claimed
      end
    end

    describe "#claimed_player" do
      it "is the claim_player" do
        expect(destination.claimed_player).to eq claim_player
      end
    end
  end
end
