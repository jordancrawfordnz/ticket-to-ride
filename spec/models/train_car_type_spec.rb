require "rails_helper"
require "spec_helper"

describe TrainCarType, type: :model do
  let(:name) { "Locomotive" }
  let(:total) { 10 }
  let(:parameters) { { name: name, total: total } }
  let(:train_car_type) { TrainCarType.new(parameters) }

  RSpec.shared_examples "train car type is invalid" do
    context "then it" do
      it "is invalid" do
        expect(train_car_type).not_to be_valid
      end
    end
  end

  describe "on creation" do
    context "if the name is nil" do
      let(:name) { nil }

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

    context "if provided a name and total" do
      it "is valid" do
        expect(train_car_type).to be_valid
      end
    end
  end
end
