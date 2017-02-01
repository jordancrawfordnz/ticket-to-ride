require "rails_helper"
require "spec_helper"

describe DealTrainCars do
  let(:game) { Game.create! }
  let(:player) { Player.create!(name: "Player 1", game: game, colour: "Red", train_pieces: 40) }
  let(:amount_to_deal) { 2 }
  let(:parameters) { { player: player, amount_to_deal: amount_to_deal } }
  let(:deal_train_cards) { DealTrainCars.new(parameters) }

  describe "#call" do
    context "with one type of train car" do
      let(:total_cards) { 3 }
      let(:train_car_type_params) { { name: "Test Car", total: total_cards } }
      let(:assigned_cards) { 0 }

      before do
        TrainCarType.destroy_all
        train_car_type = TrainCarType.create!(train_car_type_params)

        assigned_cards.times do
          DealtTrainCar.create!(player: player, train_car_type: train_car_type)
        end
      end

      shared_examples "deals cards successfully" do
        it "returns something truthy" do
          expect(deal_train_cards.call).to be_truthy
        end

        it "returns the amount to deal worth of cards" do
          expect(deal_train_cards.call.length).to eq amount_to_deal
        end

        it "adds cards to the players train car cards" do
          expect { deal_train_cards.call }.to change { player.dealt_train_cars.count }.by(amount_to_deal)
        end
      end

      shared_examples "cannot deal due to insufficient cards remaining" do
        it "returns a falsy result" do
          expect(deal_train_cards.call).to be_falsy
        end

        it "does not issue any cards" do
          expect { deal_train_cards.call }.not_to change { player.dealt_train_cars.count }
        end
      end

      context "deal two cards on a fresh deck" do
        include_examples "deals cards successfully"
      end

      context "deal one card when only one remains" do
        let(:assigned_cards) { total_cards - 1 }
        let(:amount_to_deal) { 1 }

        include_examples "deals cards successfully"
      end

      context "deal two cards when only one remains" do
        let(:assigned_cards) { total_cards - 1 }
        let(:amount_to_deal) { 2 }

        include_examples "cannot deal due to insufficient cards remaining"
      end

      context "deal one card when none remain" do
        let(:assigned_cards) { total_cards }
        let(:amount_to_deal) { 1 }

        include_examples "cannot deal due to insufficient cards remaining"
      end

      context "deal two cards when none remain" do
        let(:assigned_cards) { total_cards }
        let(:amount_to_deal) { 2 }

        include_examples "cannot deal due to insufficient cards remaining"
      end
    end

    context "with two types of train card" do
      let(:train_car_type1_params) { { name: "Test Car 1", total: 3 } }
      let(:train_car_type2_params) { { name: "Test Car 2", total: 1 } }
      let(:assigned_cards) { 0 }
      let(:train_car_type1) { TrainCarType.new(train_car_type1_params) }
      let(:train_car_type2) { TrainCarType.new(train_car_type2_params) }
      let(:amount_to_deal) { 1 }

      before do
        srand 10

        TrainCarType.destroy_all
        train_car_type1.save!
        train_car_type2.save!
      end

      it "randomly assigns train cards" do
        4.times do
          call_result = DealTrainCars.new(parameters).call
          expect(call_result).not_to be false
          expect(call_result.first.train_car_type).to be_in([train_car_type1, train_car_type2])
        end
      end
    end
  end
end
