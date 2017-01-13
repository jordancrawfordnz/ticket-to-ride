require "rails_helper"
require "spec_helper"

describe SetupGame do
  let(:setup_game_instance) { SetupGame.new(player_details: player_details) }
  let(:player1_details) { { name: "Player 1", colour: "red" } }
  let(:player2_details) { { name: "Player 2", colour: "green" } }
  let(:player_details) { { "player1" => player1_details, "player2" => player2_details } }

  shared_examples "does not save anything" do
    it "returns false" do
      expect(setup_game_instance.call).to be false
    end

    it "does not create any Players" do
      expect { setup_game_instance.call }.to change { Player.count }.by(0)
    end

    it "does not create any Games" do
      expect { setup_game_instance.call }.to change { Game.count }.by(0)
    end
  end

  context "with valid players" do
    describe "#call" do
      it "returns true" do
        expect(setup_game_instance.call).to be true
      end

      it "creates Players" do
        expect { setup_game_instance.call }.to change { Player.count }.by(player_details.length)
      end

      it "creates a Game" do
        expect { setup_game_instance.call }.to change { Game.count }.by(1)
      end

      context "after calling" do
        before do
          setup_game_instance.call
        end

        it "has Players associated with the game" do
          game = setup_game_instance.game
          expect(game.players.count).to equal player_details.length
        end

        it "has a Game" do
          expect(setup_game_instance.game).not_to be_nil
        end

        it "has no errors" do
          expect(setup_game_instance.errors.length).to be_zero
        end

        it "deals train cards to each player" do
          game = setup_game_instance.game
          game.players.each do |player|
            expect(player.dealt_train_cars.length).to eq SetupGame::INITIAL_DEAL_AMOUNT
          end
        end

        it "players have INITIAL_TRAIN_PIECES many train pieces assigned" do
          game = setup_game_instance.game
          game.players.each do |player|
            expect(player.train_pieces).to eq SetupGame::INITIAL_TRAIN_PIECES
          end
        end
      end
    end
  end

  context "with the second player being invalid" do
    let(:player2_details) { { name: "Player 2" } }

    describe "#call" do
      include_examples "does not save anything"

      describe "after being called" do
        before do
          setup_game_instance.call
        end

        it "does not have a Game" do
          expect(setup_game_instance.game).to be_nil
        end

        it "has errors" do
          expect(setup_game_instance.errors.length).not_to be_zero
        end

        it "has an error for player2" do
          expect(setup_game_instance.errors["player2"].first).not_to be_nil
        end
      end
    end
  end

  context "when there are no train cars to deal" do
    before do
      expect(DealTrainCars).to receive(:new).twice { instance_double(DealTrainCars, call: nil) }
    end

    include_examples "does not save anything"

    describe "after being called" do
      before do
        setup_game_instance.call
      end

      it "both players have errors" do
        ["player1", "player2"].each do |player_id|
          expect(setup_game_instance.errors[player_id]).to include SetupGame::NOT_ENOUGH_CARDS_TO_DEAL_MESSAGE
        end
      end
    end
  end

end
