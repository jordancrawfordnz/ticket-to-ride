require "rails_helper"
require "spec_helper"

describe DealTrainCars do
  let(:game) { Game.create! }
  let(:player) { Player.create!(name: "Player 1", game: game, colour: "Red") }
  let(:amount_to_deal) { 2 }
  let(:parameters) { { player: player, amount_to_deal: amount_to_deal } }
  let(:deal_train_cards) { DealTrainCars.new(parameters) }

  describe "#call" do
    it "returns something truthy" do
      expect(deal_train_cards.call).to be_truthy
    end

    it "returns the amount to deal worth of cards" do
      expect(deal_train_cards.call.length).to eq amount_to_deal
    end

    it "adds cards to the players train car cards" do
      expect { deal_train_cards.call }.to change { player.dealt_train_cars.count }.by(amount_to_deal)
    end

    # TODO: Add tests that check that the random card selected is the one expected.
  end
end
