require "rails_helper"
require 'spec_helper'

describe Player do
  let(:name) { "Player 1" }
  let(:name_alt) { "Player 2" }
  let(:colour) { "Green" }
  let(:game) { Game.new }
  let(:game_alt) { Game.new }
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

  context "when there is an existing Green player" do
    before do
      Player.create(parameters)
    end

    it "creating another Green player for the same game is invalid" do
      expect(Player.new({name: name_alt, colour: colour, game: game})).not_to be_valid
    end

    it "creating another Green player for a different game is valid" do
      expect(Player.new({name: name_alt, colour: colour, game: game_alt})).to be_valid
    end
  end
end
