require "rails_helper"
require "spec_helper"

describe SetupGame do
  let(:setup_game_instance) { SetupGame.new(player_details: player_details) }
  let(:player1_details) { { name: "Player 1", colour: "red" } }
  let(:player2_details) { { name: "Player 2", colour: "green" } }
  let(:player_details) { [ player1_details, player2_details ] }

  context "with valid players" do
    describe "#call" do
      it "returns true" do
        expect(setup_game_instance.call).to be true
      end

      it "creates Players" do
        expect { setup_game_instance.call }.to change { Player.count }.by(player_details.length)
      end

      it "has Players associated with the game" do
        setup_game_instance.call
        game = setup_game_instance.game
        expect(game.players.count).to equal player_details.length
      end
      
      before do
        setup_game_instance.call
      end

      it "has a Game" do
        expect(setup_game_instance.game).not_to be_nil
      end

      it "has no errors" do
        expect(setup_game_instance.errors.length).to be_zero
      end
    end
  end

  context "with the second player being invalid" do
    let(:player2_details) { { name: "Player 2" } }

    describe "#call" do
      it "returns false" do
        expect(setup_game_instance.call).to be false
      end

      it "does not create any Players" do
        expect { setup_game_instance.call }.to change { Player.count }.by(0)
      end

      before do
        setup_game_instance.call
      end

      it "does not have a Game" do
        expect(setup_game_instance.game).to be_nil
      end

      it "has errors" do
        expect(setup_game_instance.errors.length).not_to be_zero
      end
    end
  end
end
