class Api::V1::BackgroundsController < ApplicationController

  def index
    image_info = BackgroundsFacade.image_by_location(params[:location])
    render json: BackgroundsSerializer.new(image_info)
  end
end
