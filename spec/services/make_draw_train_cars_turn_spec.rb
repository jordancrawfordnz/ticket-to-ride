require "rails_helper"
require "spec_helper"
require "test_data_helper"

describe MakeDrawTrainCarsTurn do
  let(:game) { test_game }
  let(:player) { game.players.first }
  let(:make_draw_train_cars_turn) { MakeDrawTrainCarsTurn.new(player: player) }

  context "when there are enough train cars in the deck" do
    let(:finish_turn_result) { true }
    let(:service_double) { instance_double(FinishTurn, call: finish_turn_result) }

    before do
      expect(FinishTurn).to receive(:new).once { service_double }
      expect(service_double).to receive(:call).once
    end

    describe "#call" do
      it "calls DealTrainCards to draw 2 cards from the deck" do
        expect(DealTrainCars).to receive(:new).with(player: player, amount_to_deal: 2).and_call_original
        make_draw_train_cars_turn.call
      end

      it "returns true" do
        expect(make_draw_train_cars_turn.call).to be true
      end

      context "if FinishTurn returns false" do
        let(:finish_turn_result) { false }

        it "returns false" do
          expect(make_draw_train_cars_turn.call).to be false
        end
      end
    end
  end

  context "when there are not enough train cars in the deck" do
    before do
      expect(DealTrainCars).to receive(:new) { instance_double(DealTrainCars, call: false) }
      expect(FinishTurn).not_to receive(:new)
    end

    it "returns false" do
      expect(make_draw_train_cars_turn.call).to be false
    end
  end
end
