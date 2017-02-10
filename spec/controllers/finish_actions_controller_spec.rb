require "rails_helper"
require "spec_helper"
require "rspec/mocks"
require "test_data_helper"

describe FinishActionsController do
  shared_examples "redirects to the game page with expected errors" do
    it "redirects to the game page" do
      expect(response).to redirect_to service_game
    end

    it "has the expected errors in the flash" do
      expect(flash[:errors]).to eq service_expected_errors
    end
  end

  describe "POST create" do
    def post_create
      post :create, params: { game_id: service_game.id }
    end

    let(:service_result) { true }
    let(:service_expected_errors) { nil }
    let(:service_double) { instance_double(FinishPlayerActions, call: service_result) }
    let(:players) { test_players }
    let(:service_game) { Game.new(players: players, current_player: players.first) }

    before do
      service_game.save!
      expect(FinishPlayerActions).to receive(:new) { service_double }.with(game: service_game)
    end

    it "calls FinishPlayerActions#call" do
      expect(service_double).to receive(:call)
      post_create
    end

    context "after making a request" do
      before do
        post_create
      end

      context "on service success" do
        include_examples "redirects to the game page with expected errors"
      end

      context "on service failure" do
        let(:service_result) { false }
        let(:service_expected_errors) { [ FinishActionsController::FINISH_ACTION_FAILED_ERROR ] }

        include_examples "redirects to the game page with expected errors"
      end
    end
  end
end
