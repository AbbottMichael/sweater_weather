class Api::V1::BookSearchController < ApplicationController

  def index
    coordinates = MapFacade.lat_lng(params[:location])
    forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
    books = BookSearchFacade.books_by_city(forecast, params[:location], params[:quantity])
    render json: BooksSerializer.new(books)
  end
end
