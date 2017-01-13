require "rails_helper"
require 'spec_helper'

describe Player do
  let(:train_car_type) { TrainCarType.find_by(name: "Locomotive") }
  let(:name) { "Player 1" }
  let(:name_alt) { "Player 2" }
  let(:colour) { "Green" }
  let(:game) { Game.new }
  let(:game_alt) { Game.new }
  let(:player) { Player.new(parameters) }
  let(:train_pieces) { 45 }
  let(:parameters) { {name: name, colour: colour, game: game, train_pieces: train_pieces} }

  context "provided a valid name, colour and game" do
    it "is valid" do
      expect(player).to be_valid
    end
  end

  RSpec.shared_examples "player is invalid" do
    context "then it" do
      it "is invalid" do
        expect(player).not_to be_valid
      end
    end
  end

  describe "on initialize" do
    context "if the name is nil" do
      let(:name) { nil }

      include_examples "player is invalid"
    end

    context "when the colour is nil" do
      let(:colour) { nil }

      include_examples "player is invalid"
    end

    context "when the game is nil" do
      let(:game) { nil }

      include_examples "player is invalid"
    end

    context "when the train_pieces are nil" do
      let(:train_pieces) { nil }

      include_examples "player is invalid"
    end

    context "when the train_pieces are negative" do
      let(:train_pieces) { -40 }

      include_examples "player is invalid"
    end

    context "when there is an existing Green player" do
      before do
        Player.create(parameters)
      end

      it "creating another Green player for the same game is invalid" do
        expect(Player.new({name: name_alt, colour: colour, game: game, train_pieces: 20})).not_to be_valid
      end

      it "creating another Green player for a different game is valid" do
        expect(Player.new({name: name_alt, colour: colour, game: game_alt, train_pieces: 20})).to be_valid
      end
    end
  end

  describe "#dealt_train_cars" do
    context "when no dealt train cars" do
      it "should be empty" do
        expect(player.dealt_train_cars).to eq []
      end
    end

    context "when a player is dealt a train car" do
      before do
        @dealt_car = DealtTrainCar.create(player: player, train_car_type: train_car_type)
      end

      it "should contain the dealt car" do
        expect(player.dealt_train_cars).to eq [@dealt_car]
      end
    end
  end
end
