require 'rails_helper'
require 'test_data_helper'

describe FinishPlayerActions do
  let(:current_player) { players.first }
  let(:players) { test_players }
  let(:finished_action) { false }
  let(:game_parameters) { { current_player: current_player, players: players, finished_action: finished_action } }
  let(:game) { Game.new(game_parameters) }
  let(:parameters) { { game: game } }
  let(:finish_player_actions) { FinishPlayerActions.new(parameters) }

  before do
    game.save if game
  end

  describe "on initialise" do
    shared_examples "raises error on initialise" do
      it "should raise an error" do
        expect { finish_player_actions }.to raise_error(ArgumentError)
      end
    end

    shared_examples "is initialised without error" do
      it "should not raise an error" do
        expect { finish_player_actions }.not_to raise_error
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
    shared_examples "returns false and does not change the game" do
      it "returns false" do
        expect(finish_player_actions.call).to be false
      end

      it "does not change the game" do
        expect { finish_player_actions.call }.not_to change { game.finished_action }
      end
    end

    shared_examples "returns true and finished action is true" do
      it "returns true" do
        expect(finish_player_actions.call).to be true
      end

      it "sets finished_action to true" do
        finish_player_actions.call
        expect(game.finished_action).to be true
      end
    end

    context "when already finished actions" do
      let(:finished_action) { true }

      include_examples "returns false and does not change the game"
    end

    context "when not finished actions" do
      include_examples "returns true and finished action is true"
    end
  end
end
