class Api::V1::ForecastController < ApplicationController

  def index
    coordinates = MapFacade.lat_lng(params[:location])
    forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
    render json: ForecastSerializer.new(forecast)
  end
end
