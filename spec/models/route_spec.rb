require 'rails_helper'

describe Route do
  let(:route) { Route.new(parameters) }
  let(:pieces) { 3 }
  let(:parameters) { { city1: city1, city2: city2, pieces: pieces } }
  let(:city1) { City.new({ name: "City 1" })}
  let(:city2) { City.new({ name: "City 2" })}

  # TODO: Prevent duplicates.

  shared_examples "route is invalid" do
    it "is invalid" do
      expect(route).not_to be_valid
    end
  end

  describe "on initialize" do
    context "with valid params" do
      it "is valid" do
        expect(route).to be_valid
      end
    end

    context "with no pieces" do
      let(:pieces) { nil }

      include_examples "route is invalid"
    end

    context "with no city1" do
      let(:city1) { nil }

      include_examples "route is invalid"
    end

    context "with no city2" do
      let(:city2) { nil }

      include_examples "route is invalid"
    end
  end
end
