class Api::V1::RoadTripController < ApplicationController
  prepend_before_action :authenticator, only: [:create]

  def create
    coordinates = MapFacade.lat_lng(trip_params[:destination])
    forecast = ForecastFacade.forecast_by_lat_lng(coordinates.lat, coordinates.lng)
    trip_info = RoadTripFacade.trip_details(trip_params[:origin], trip_params[:destination], forecast)
    render json: RoadTripSerializer.new(trip_info)
  end

  private

  def trip_params
    params.require(:road_trip).
      permit(:origin, :destination, :api_key)
  end

  def params_verify
    begin
      if trip_params[:origin].nil? || trip_params[:destination].nil? || trip_params[:api_key].nil?
        return (render json: {error: "Must provide an origin and a destination"}, status: :bad_request)
      end
    rescue => e
      return (render json: {error: "Must provide input in the body"}, status: :bad_request)
    end
  end

  def authenticator
    params_verify
    auth = ApiKey.find_by(token: trip_params[:api_key])
    return (render json:
      { error: "Not authorized. Please provide a valid API key" },
        status: :unauthorized) if auth.nil?
  end
end
