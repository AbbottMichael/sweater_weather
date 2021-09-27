require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes', :vcr do
    forecast = ForecastService.get_forecast_by_lat_lon(39.738453, -104.984853)
    data = BookService.get_books_by_city('denver,co', 5)

    results = Book.new(data, forecast)
  end
end
