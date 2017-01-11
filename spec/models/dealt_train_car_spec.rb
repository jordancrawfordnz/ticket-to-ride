require 'rails_helper'

RSpec.describe DealtTrainCar, type: :model do
  let(:player) { Player.new(name: "Player 1") }
  let(:train_car_type) { TrainCarType.find_by(name: "Locomotive") }
  let(:parameters) { { player: player, train_car_type: train_car_type } }
  let(:dealt_train_car) { DealtTrainCar.new(parameters) }

  RSpec.shared_examples "dealt train car is invalid" do
    context "then it" do
      it "is invalid" do
        expect(dealt_train_car).not_to be_valid
      end
    end
  end

  context "if no parameters" do
    let(:parameters) { nil }

    include_examples "dealt train car is invalid"
  end

  context "if the player is nil" do
    let(:player) { nil }

    include_examples "dealt train car is invalid"
  end

  context "the train car type is nil" do
    let(:train_car_type) { nil }

    include_examples "dealt train car is invalid"
  end

  context "with valid parameters" do
    it "is valid" do
      expect(dealt_train_car).to be_valid
    end
  end
end
