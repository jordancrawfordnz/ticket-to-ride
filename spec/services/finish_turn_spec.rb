require 'rails_helper'
require 'test_data_helper'

describe FinishTurn do
  let(:current_player) { players.first }
  let(:players) { test_players }
  let(:finished_action) { true }
  let(:game) { Game.new(current_player: current_player, players: players, finished_action: finished_action) }
  let(:parameters) { { game: game } }
  let(:finish_turn) { FinishTurn.new(parameters) }

  before do
    game.save if game
  end

  describe "on initialise" do
    shared_examples "raises error on initialise" do
      it "should raise an error" do
        expect { finish_turn }.to raise_error(ArgumentError)
      end
    end

    shared_examples "is initialised without error" do
      it "should not raise an error" do
        expect { finish_turn }.not_to raise_error
      end
    end

    context "with a nil game" do
      let(:game) { nil }

      include_examples "raises error on initialise"
    end

    context "with valid params" do
      include_examples "is initialised without error"
    end
  end

  describe "#call" do
    shared_examples "returns false and does not change the player" do
      it "returns false" do
        expect(finish_turn.call).to be false
      end

      it "does not change the player" do
        expect { finish_turn.call }.not_to change { game.current_player }
      end
    end

    shared_examples "returns true and the current player is as expected" do
      it "returns true" do
        expect(finish_turn.call).to be true
      end

      context "after finishing the turn" do
        before do
          finish_turn.call
        end

        it "sets the player to the expected current_player" do
          expect(game.current_player).to eq expected_current_player
        end

        it "sets the game's finished_action to false" do
          expect(game.finished_action).to be false
        end
      end
    end

    context "with no players" do
      let(:players) { [] }
      let(:current_player) { test_players.first }

      include_examples "returns false and does not change the player"
    end

    context "when on the first player" do
      let(:expected_current_player) { players.second }

      include_examples "returns true and the current player is as expected"
    end

    context "when on the last player" do
      let(:current_player) { players.last }
      let(:expected_current_player) { players.first }

      include_examples "returns true and the current player is as expected"
    end

    context "when finished_action is false" do
      let(:finished_action) { false }

      include_examples "returns false and does not change the player"
    end
  end
end
