class ForecastService
  def self.get_forecast_by_lat_lon(lat, lon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'minutely,alerts'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params['appid'] = ENV['openweather_api_key']
    end
  end
end
