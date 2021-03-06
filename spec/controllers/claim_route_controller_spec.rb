require 'rails_helper'
require 'test_data_helper'

describe ClaimRouteController do
  shared_examples "redirects to the game page with expected errors" do
    it "redirects to the game page" do
      expect(response).to redirect_to game
    end

    it "has the expected errors in the flash with error prefix" do
      expect(flash[:errors]).to eq service_expected_errors_prefixed
    end
  end

  describe "POST claim_route" do
    def post_claim_route
      post :create, params: params
    end

    let(:route) { saved test_route }
    let(:params) { { game_id: game.id, route_id: route.id, dealt_train_car_ids: train_cars.map(&:id) } }
    let(:players) { test_players }
    let(:player) { game.current_player }
    let(:game) { Game.new(players: players, current_player: players.first) }
    let(:train_cars) { assign_train_cars(count: 5, player: player) }

    let(:service_result) { true }
    let(:service_expected_errors) { nil }
    let(:service_expected_errors_prefixed) do
     service_expected_errors.map { |message| ClaimRouteController::ERROR_PREFIX + message } if service_expected_errors
    end
    let(:service_double) { instance_double(ClaimRoute, call: service_result, errors: service_expected_errors) }

    before do
      game.save!
      expect(ClaimRoute).to receive(:new) { service_double }.with(player: player, train_cars: train_cars, route: route)
    end

    it "calls ClaimRoute#call" do
      expect(service_double).to receive(:call)
      post_claim_route
    end

    context "after making a request" do
      before do
        post_claim_route
      end

      context "on success success" do
        include_examples "redirects to the game page with expected errors"
      end

      context "on ClaimRoute failure" do
        let(:service_result) { false }
        let(:service_expected_errors) { [ClaimRoute::REQUIRED_PARAMETERS_NOT_PROVIDED] }

        include_examples "redirects to the game page with expected errors"
      end
    end
  end
end
