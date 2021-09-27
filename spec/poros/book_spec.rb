require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes', :vcr do
    location = 'denver,co'
    forecast = ForecastService.get_forecast_by_lat_lon(39.738453, -104.984853)
    data = BookService.get_books_by_city(location, 5)

    results = Book.new(data, forecast, location)

    expect(results).to be_a(Book)
  end
end
