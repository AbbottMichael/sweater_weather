class Api::V1::RoadTripController < ApplicationController
  prepend_before_action :authenticator, only: [:create]

  def create
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
