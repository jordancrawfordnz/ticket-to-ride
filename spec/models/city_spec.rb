require 'rails_helper'

describe City do
  let(:city) { City.new(parameters) }
  let(:city_alt) { City.new(parameters_alt) }

  let(:saved_city) do
    city.save
    city
  end
  let(:saved_city_alt) do
    city_alt.save
    city_alt
  end

  let(:name) { "Test City" }
  let(:name_alt) { "Test City Alternative" }

  let(:parameters) { { name: name } }
  let(:parameters_alt) { { name: name_alt } }

  shared_examples "city is invalid" do
    it "is invalid" do
      expect(city).not_to be_valid
    end
  end

  describe "on initialize" do
    context "with valid params" do
      it "is valid" do
        expect(city).to be_valid
      end
    end

    context "with no name" do
      let(:name) { nil }

      include_examples "city is invalid"
    end
  end

  describe "#routes" do
    shared_examples "has expected routes" do
      it "has the route" do
        expect(city.routes).to eq expected_routes
      end
    end

    context "with no routes" do
      let(:expected_routes) { [] }
      include_examples "has expected routes"
    end

    context "when a route is defined" do
      let(:route_pieces) { 3 }
      let(:expected_routes) { [ route ] }
      let(:route_type) { RouteType.new(colour: "Green") }
      let(:route) { Route.new(pieces: route_pieces, city1: route_city1, city2: route_city2, route_type: route_type) }

      before do
        route.save!
      end

      context "when set as the city1 in a route" do
        let(:route_city1) { saved_city }
        let(:route_city2) { saved_city_alt }

        include_examples "has expected routes"
      end

      context "when set as the city2 in a route" do
        let(:route_city1) { saved_city_alt }
        let(:route_city2) { saved_city }

        include_examples "has expected routes"
      end
    end
  end
end
