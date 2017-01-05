require "rails_helper"
require "spec_helper"

describe SetupGame do
  let(:setup_game_instance) { SetupGame.new(player_details: player_details) }
  let(:player_details) do
    [
      {
        name: "Player 1",
        colour: "red"
      },
      {
        name: "Player 2",
        colour: "green"
      }
    ]
  end

  context "with valid parameters" do
    describe "#call" do
      it "returns true" do
        expect(setup_game_instance.call).to be true
      end

      it "creates Players" do
        expect { setup_game_instance.call }.to change { Player.count }.by(player_details.length)
      end

      before do
        setup_game_instance.call
      end

      it "has a Game" do
        expect(setup_game_instance.game).not_to be_nil
      end
    end
  end
end
