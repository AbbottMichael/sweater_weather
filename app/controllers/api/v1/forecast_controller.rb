class Api::V1::ForecastController < ApplicationController

  def index
    coordinates = MapFacade.lat_lng(params[:location])
  end
end
