require 'rails_helper'

RSpec.describe RoadTripService do
  context "class methods" do
    context "::get_trip_details" do
      it "returns the details about the road trip between an origin and destination", :vcr do
        trip = RoadTripService.get_trip_details('denver,co', 'Estes Park, CO')

        expect(trip).to be_a(Hash)
      end
    end
  end
end
