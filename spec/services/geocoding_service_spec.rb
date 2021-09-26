require 'rails_helper'

RSpec.describe GeocodingService do
  context "class methods" do
    context "#get_lat_lng_by_location" do
      it "returns the latitude and longitude of a given city and state" do
        search = GeocodingService.get_lat_lng_by_location("denver,co")
        expect(search).to be_an Array
        expect(search[:locations]).to be_an Array
        location_data = search[:locations].first

        expect(location_data).to have_key(:latLng)
        expect(location_data[:latLng]).to be_a(Hash)
        expect(location_data[:latLng]).to have_key(:lat)
        expect(location_data[:latLng][:lat]).to be_a(Float)
        expect(location_data[:latLng]).to have_key(:lng)
        expect(location_data[:latLng][:lng]).to be_a(Float)
      end
    end
  end
end
