class Api::V1::RoadTripController < ApplicationController
  prepend_before_action :authenticator, only: [:create]

  def create
    coordinates = MapFacade.lat_lng(trip_params[:destination])
    forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
    trip_info = RoadTripFacade.trip_details(trip_params[:origin], trip_params[:destination], forecast)
  end

  private

  def trip_params
    params.require(:road_trip).
      permit(:origin, :destination, :api_key)
  end

  def authenticator
    auth = ApiKey.find_by(token: trip_params[:api_key])
    return (render json:
      { error: "Not authorized. Please provide a valid API key" },
        status: :unauthorized) if auth.nil?
  end
end
