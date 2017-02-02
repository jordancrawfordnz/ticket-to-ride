require "rails_helper"
require "spec_helper"

describe TrainCarType, type: :model do
  let(:name) { "Locomotive" }
  let(:total) { 10 }
  let(:colour) { "Multi" }
  let(:parameters) { { name: name, total: total, colour: colour } }
  let(:train_car_type) { TrainCarType.new(parameters) }

  shared_examples "train car type is invalid" do
    it "is invalid" do
        expect(train_car_type).not_to be_valid
    end
  end

  shared_examples "train car type is valid" do
    it "is valid" do
      expect(train_car_type).to be_valid
    end
  end

  describe "on creation" do
    context "if the name is nil" do
      let(:name) { nil }

      include_examples "train car type is invalid"
    end

    context "if the colour is nil" do
      let(:colour) { nil }

      include_examples "train car type is invalid"
    end

    context "if the total is nil" do
      let(:total) { nil }

      include_examples "train car type is invalid"
    end

    context "if provided no parameters" do
      let(:parameters) { nil }

      include_examples "train car type is invalid"
    end

    context "if wildcard" do
      let(:parameters) { { name: name, total: total, colour: colour, wildcard: true } }

      include_examples "train car type is valid"
    end

    context "if provided a name and total" do
      include_examples "train car type is valid"
    end
  end
end
