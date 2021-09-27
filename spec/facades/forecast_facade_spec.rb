require 'rails_helper'

RSpec.describe ForecastFacade do
  context "class methods" do
    context "::forecast_by_lat_lng" do
      it "returns an array of Map objects", :vcr do
        results = ForecastFacade.forecast_by_lat_lng(39.738453, -104.984853)

        expect(results).to be_a(Forecast)
      end
    end
  end
end
