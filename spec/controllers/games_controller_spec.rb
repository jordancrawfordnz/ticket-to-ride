require "rails_helper"
require "spec_helper"
require "rspec/mocks"
require "test_data_helper"

describe GamesController do
  shared_examples "redirects to the game page with expected errors" do
    it "redirects to the game page" do
      expect(response).to redirect_to service_game
    end

    it "has the expected errors in the flash" do
      expect(flash[:errors]).to eq service_expected_errors
    end
  end

  describe "POST draw_train_cars" do
    def post_draw_train_cars
      post :draw_train_cars, params: { id: service_game.id }
    end

    let(:service_result) { true }
    let(:service_expected_errors) { nil }
    let(:service_double) { instance_double(MakeDrawTrainCarsTurn, call: service_result) }
    let(:players) { test_players }
    let(:service_game) { Game.new(players: players, current_player: players.first) }

    before do
      service_game.save!
      expect(MakeDrawTrainCarsTurn).to receive(:new) { service_double }.with(player: service_game.players.first)
    end

    it "calls MakeDrawTrainCarsTurn#call" do
      expect(service_double).to receive(:call)
      post_draw_train_cars
    end

    context "after making a request" do
      before do
        post_draw_train_cars
      end

      context "on draw success" do
        include_examples "redirects to the game page with expected errors"
      end

      context "on draw failure" do
        let(:service_result) { false }
        let(:service_expected_errors) { [ GamesController::DRAW_TRAIN_CARS_FAILED_ERROR ] }

        include_examples "redirects to the game page with expected errors"
      end
    end
  end

  describe "POST create" do
    def post_create
      post :create, params: params
    end

    let(:service_result) { true }
    let(:service_errors) { {} }
    let(:service_game) { Game.new }

    let(:service_double) do
      instance_double(SetupGame,
                      call: service_result,
                      errors: service_errors,
                      game: service_game)
    end
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
            "player1": player1_details,
            "player2": player2_details
          }
        }
      }
    }

    before do
      expect(SetupGame).to receive(:new) { service_double }
        .with(player_details: {
          "player1" => player1_details,
          "player2" => player2_details
        })
    end

    it "calls SetupGame#call" do
      expect(service_double).to receive(:call).once
      post_create
    end

    context "on SetupGame success" do
      before do
        post_create
      end

      it "redirects to the game page" do
        expect(response).to redirect_to service_game
      end
    end

    context "on SetupGame error" do
      before { post_create }

      let(:service_result) { false }
      let(:service_errors) { { "player1" => ["Error!"] } }

      it "redirects to the new game page" do
        expect(response).to redirect_to :new_game
      end

      it "puts errors in the flash" do
        expect(flash[:errors]).to equal service_errors
      end
    end
  end
end
