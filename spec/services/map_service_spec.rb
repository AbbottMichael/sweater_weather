require 'rails_helper'

RSpec.describe MapService do
  context "class methods" do
    context "::get_lat_lng_by_location" do
      it "returns the latitude and longitude of a given city and state", :vcr do
        search = MapService.get_lat_lng_by_location("denver,co")
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        results = search[:results].first
        expect(results).to have_key(:locations)
        expect(results[:locations]).to be_an(Array)
        location = results[:locations].first

        expect(location).to have_key(:latLng)
        expect(location[:latLng]).to be_a(Hash)
        expect(location[:latLng]).to have_key(:lat)
        expect(location[:latLng][:lat]).to be_a(Float)
        expect(location[:latLng]).to have_key(:lng)
        expect(location[:latLng][:lng]).to be_a(Float)
      end
    end
  end
end
