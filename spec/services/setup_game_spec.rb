require "rails_helper"
require "spec_helper"

describe SetupGame do
  shared_examples "does not save anything" do
    it "returns falsey" do
      expect(setup_game_instance.call).to be_falsey
    end

    it "does not create any Players" do
      expect { setup_game_instance.call }.not_to change { Player.count }
    end

    it "does not create any Games" do
      expect { setup_game_instance.call }.not_to change { Game.count }
    end
  end

  let(:setup_game_instance) { SetupGame.new(player_details: player_details) }
  let(:player1_details) { { name: "Player 1", colour: "red" } }
  let(:player2_details) { { name: "Player 2", colour: "green" } }
  let(:player_details) { { "player1" => player1_details, "player2" => player2_details } }

  context "with valid players" do
    describe "#call" do
      it "returns truthy" do
        expect(setup_game_instance.call).to be_truthy
      end

      it "creates Players" do
        expect { setup_game_instance.call }.to change { Player.count }.by(player_details.length)
      end

      it "creates a Game" do
        expect { setup_game_instance.call }.to change { Game.count }.by(1)
      end
    end

    context "the game has been setup" do
      let(:game) do
        setup_game_instance.call
        setup_game_instance.game
      end

      let(:errors) do
        setup_game_instance.call
        setup_game_instance.errors
      end

      describe "#errors" do
        it "has no errors" do
          expect(errors.length).to be_zero
        end
      end

      describe "#game" do
        it "sets up Players associated with the game" do
          expect(game.players.count).to equal player_details.length
        end

        it "deals train cards to each player" do
          game.players.each do |player|
            expect(player.dealt_train_cars.length).to eq SetupGame::INITIAL_DEAL_AMOUNT
          end
        end

        it "players have INITIAL_TRAIN_PIECES many train pieces assigned" do
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
          expect(setup_game_instance.errors[player_id]).to include SetupGame::NOT_ENOUGH_CARDS_TO_DEAL
        end
      end
    end
  end

end
