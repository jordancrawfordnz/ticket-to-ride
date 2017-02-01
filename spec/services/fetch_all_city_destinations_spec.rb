require 'rails_helper'
require 'test_data_helper'

describe FetchAllCityDestinations do
  let(:fetch_all_city_destinations) { FetchAllCityDestinations.new }

  shared_examples "is a valid city destinations entry" do |city_destination|
    describe "[:city]" do
      it "is not nil" do
        expect(city_destination[:city]).not_to be_nil
      end
    end

    describe "[:destinations]" do
      it "has a destination for all the cities routes" do
        expect(city_destination[:destinations].length).to eq city_destination.city.routes.length
      end
    end
  end

  describe "#call" do
    before { @call_result = fetch_all_city_destinations.call }

    it "has a non nil result" do
      expect(@call_result).not_to be_nil
    end

    it "has as many city destination entries as the number of cities" do
      expect(@call_result.length).to eq City.size
    end

    it "has a valid city destinations entry for each city" do
      @call_result.each do |city_destination|
        include_examples "is a valid city destinations entry", city_destination
      end
    end
  end
end
