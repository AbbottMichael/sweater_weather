require 'rails_helper'

RSpec.describe BookSearchFacade do
  context "class methods" do
    context "::books_by_city" do
      it "returns book objects", :vcr do
        coordinates = MapFacade.lat_lng('denver,co')
        forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
        results = BookSearchFacade.books_by_city(forecast, 'denver,co', 5)

        expect(results).to be_a(Book)
      end
    end
  end
end
