require "rails_helper"
require 'spec_helper'

describe Player do
  let(:name) { "Player 1" }
  let(:colour) { "green" }
  let(:game) { Game.new }
  let(:parameters) { {name: name, colour: colour, game: game} }

  context "provided a valid name, colour and game" do
    it "is valid" do
      expect(Player.new(parameters)).to be_valid
    end
  end

  RSpec.shared_examples "player is invalid" do
    context "then it" do
      it "is invalid" do
        expect(Player.new(parameters)).not_to be_valid
      end
    end
  end

  context "if the name is nil" do
    let(:name) { nil }

    include_examples "player is invalid"
  end

  context "the colour is nil" do
    let(:colour) { nil }

    include_examples "player is invalid"
  end

  context "the game is nil" do
    let(:game) { nil }

    include_examples "player is invalid"
  end
end
