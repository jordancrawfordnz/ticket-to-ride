require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe RouteClaim do
  let(:route) { test_route }
  let(:player) { test_players[0] }

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
