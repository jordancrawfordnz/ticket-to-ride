require "rails_helper"
require "spec_helper"
require "rspec/mocks"

describe GamesController do
  describe "POST create" do
    let(:setup_game_result) { true }
    let(:setup_game_errors) { [] }
    let(:setup_game_game) { Game.new }
    let(:setup_game_double) { instance_double(SetupGame, call: setup_game_result, errors: setup_game_errors, game: setup_game_game) }
    let(:player1_details) {
      {
        name: "Player 1",
        colour: "green"
      }
    }
    let(:player2_details) {
      {
        name: "Player 2",
        colour: "blue"
      }
    }
    let(:params) {
      {
        game: {
          players: {
            player1: player1_details,
            player2: player2_details
          }
        }
      }
    }

    def post_create
      post :create, params: params
    end

    before do
      expect(SetupGame).to receive(:new) { setup_game_double }.with(player_details: [ player1_details, player2_details ])
    end

    it "calls SetupGame#call" do
      expect(setup_game_double).to receive(:call)
      post_create
    end

    context "on SetupGame success" do
      before do
        post_create
      end

      it "redirects to the game page" do
        expect(response).to redirect_to setup_game_game
      end
    end

    context "on SetupGame error" do
      before do
        post_create
      end

      let(:setup_game_result) { false }
      let(:setup_game_errors) { [ "Error" ] }

      it "redirects to the new game page" do
        expect(response).to redirect_to :new_game
      end

      it "puts errors in the flash" do
        expect(flash[:errors]).to equal setup_game_errors
      end
    end
  end
end
