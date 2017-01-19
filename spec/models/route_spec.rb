require 'rails_helper'

describe Route do
  let(:route) { Route.new(parameters) }
  let(:pieces) { 3 }
  let(:parameters) { { city1: city1_saved, city2: city2_saved, pieces: pieces } }
  let(:city1) { City.new({ name: "City 1" })}
  let(:city2) { City.new({ name: "City 2" })}
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
      let(:city1_saved) { nil }

      include_examples "route is invalid"
    end

    context "with no city2" do
      let(:city2_saved) { nil }

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
end
