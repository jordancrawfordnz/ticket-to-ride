require 'rails_helper'
require 'test_data_helper'

describe FetchAllCityDestinations do
  let(:game) { test_game }
  let(:fetch_all_city_destinations) { FetchAllCityDestinations.new(game: game) }

  describe "#call" do
    before { @call_result = fetch_all_city_destinations.call }

    it "has a non nil result" do
      expect(@call_result).not_to be_nil
    end

    it "has as many city destination entries as the number of cities" do
      expect(@call_result.length).to eq City.count
    end

    context "on each city destination" do
      describe "[:city]" do
        it "is not nil on each city destination" do
          @call_result.each do |city_destination|
            expect(city_destination[:city]).not_to be_nil
          end
        end
      end

      describe "[:destinations]" do
        it "have a destination for all the cities routes" do
          @call_result.each do |city_destination|
            expect(city_destination[:destinations].length).to eq city_destination[:city].routes.length
          end
        end
      end
    end
  end
end
