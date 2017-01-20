require 'rails_helper'

describe RouteType do
  let(:colour) { "Green" }
  let(:params) { { colour: colour } }
  let(:route_type) { RouteType.new(params) }

  shared_examples "route_type is invalid" do
    it "is invalid" do
      expect(route_type).not_to be_valid
    end
  end

  describe "on initialize" do
    context "with valid params" do
      it "is valid" do
        expect(route_type).to be_valid
      end
    end

    context "with no colour" do
      let(:colour) { nil }

      include_examples "route_type is invalid"
    end
  end
end
