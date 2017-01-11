require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe Game do
  let(:train_car_type) { TrainCarType.find_by(name: "Locomotive") }
  let(:players) { test_players }
  let(:parameters) { { players: players } }
  let(:game) { Game.create(parameters) }

  describe "on initialize" do
    context "if provided no parameters" do
      let(:parameters) { {} }

      it "is valid" do
        expect(game).to be_valid
      end
    end
  end

  describe "#dealt_train_cars" do
    context "when no dealt train cars" do
      it "should be empty" do
        expect(game.dealt_train_cars).to eq []
      end
    end

    context "when a player is dealt a train car" do
      before do
        @dealt_car = DealtTrainCar.create(player: game.players.first, train_car_type: train_car_type)
      end

      it "should contain the dealt car" do
        expect(game.dealt_train_cars).to eq [@dealt_car]
      end
    end
  end
end
