class ForecastFacade

  def self.forecast_by_lat_lng(lat, lng)
    data = ForecastService.get_forecast_by_lat_lon(lat, lng)
    Forecast.new(data)
  end
end
