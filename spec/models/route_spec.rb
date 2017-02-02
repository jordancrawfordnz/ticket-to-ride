require 'rails_helper'

describe Route do
  let(:route) { Route.new(parameters) }
  let(:pieces) { 3 }
  let(:parameters) { { city1: city1_saved, city2: city2_saved, pieces: pieces, route_type: route_type } }
  let(:city1) { City.new({ name: "City 1" })}
  let(:city2) { City.new({ name: "City 2" })}
  let(:route_type) { RouteType.new({ colour: "Green" }) }

  let(:city1_saved) do
    city1.save
    city1
  end
  let(:city2_saved) do
    city2.save
    city2
  end

  shared_examples "route is invalid" do
    it "is invalid" do
      expect(route).not_to be_valid
    end
  end

  shared_examples "route is valid" do
    it "is valid" do
      expect(route).to be_valid
    end
  end

  describe "on initialize" do
    context "with valid params" do
      include_examples "route is valid"
    end

    context "with no pieces" do
      let(:pieces) { nil }

      include_examples "route is invalid"
    end

    context "with 0 pieces" do
      let(:pieces) { 0 }

      include_examples "route is invalid"
    end

    context "with less than 0 pieces" do
      let(:pieces) { -20 }

      include_examples "route is invalid"
    end

    context "with 6 pieces" do
      let(:pieces) { 6 }

      include_examples "route is valid"
    end

    context "with 7 pieces" do
      let(:pieces) { 7 }

      include_examples "route is invalid"
    end

    context "with no city1" do
      let(:city1_saved) { nil }

      include_examples "route is invalid"
    end

    context "with no city2" do
      let(:city2_saved) { nil }

      include_examples "route is invalid"
    end

    context "with no route type" do
      let(:route_type) { nil }

      include_examples "route is invalid"
    end

    context "with unsaved cities" do
      let(:parameters) { { city1: city1, city2: city2, pieces: pieces } }

      include_examples "route is invalid"
    end

    context "with city1 and city2 reversed" do
      before do
        city1.save
        city2.save
      end
      let(:parameters) { { city1: city2, city2: city1, pieces: pieces } }

      include_examples "route is invalid"
    end
  end

  context "with a route claimed" do
    let(:player) { Player.new(name: "Player 1")}
    let(:route_claim) { RouteClaim.new(player: player, route: route) }

    before do
      route_claim
    end

    it "claimed_route is not nil" do
        expect(route.route_claim).not_to be nil
    end
  end

  describe "#alternate_city" do
    let(:alternate_city) { route.alternate_city(compare_city) }

    context "when getting the alternative to city1" do
      let(:compare_city) { route.city1 }

      it "the alternate is city2" do
        expect(alternate_city).to eq route.city2
      end
    end

    context "when getting the alternative to city2" do
      let(:compare_city) { route.city2 }

      it "the alternate is city1" do
        expect(alternate_city).to eq route.city1
      end
    end

    context "when comparing with a city not in the route" do
      let(:compare_city) { City.new(name: "City") }

      it "the alternate is nil" do
        expect(alternate_city).to eq nil
      end
    end
  end
end
