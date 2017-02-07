require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe CountRemainingTrainCars do
  let(:train_car_type) { TrainCarType.find_by(name: "Locomotive") }
  let(:train_car_alt_type) { TrainCarType.find_by(name: "Box") }
  let(:players) { test_players }
  let(:game) { Game.new(players: players, current_player: players.first) }
  let(:parameters) { { train_car_type: train_car_type, game: game } }
  let(:count_remaining_train_cars) { CountRemainingTrainCars.new(parameters) }

  before do
    game.save!
  end

  context "with no assigned cards" do
    describe "#call" do
      it "returns the train car type count" do
        expect(count_remaining_train_cars.call).to eq train_car_type.total
      end
    end
  end

  context "with a card of another type dealt" do
    before do
      DealtTrainCar.create(player: game.players.first, train_car_type: train_car_alt_type)
    end

    it "returns the train car type count" do
      expect(count_remaining_train_cars.call).to eq train_car_type.total
    end
  end

  context "with a card of this type dealt" do
    before do
      DealtTrainCar.create(player: game.players.first, train_car_type: train_car_type)
    end

    it "returns the train car type count less one" do
      expect(count_remaining_train_cars.call).to eq (train_car_type.total - 1)
    end
  end
end
