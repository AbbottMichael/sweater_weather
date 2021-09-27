class Api::V1::BookSearchController < ApplicationController

  def index
    coordinates = MapFacade.lat_lng(params[:location])
    forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
    #forecast.current_weather[:description]
    #forecast.current_weather[:temperature]
  end
end
