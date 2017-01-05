require "rails_helper"
require 'spec_helper'

describe Game do
  context "if provided no parameters" do
    it "is valid" do
      expect(Game.new).to be_valid
    end
  end
end
