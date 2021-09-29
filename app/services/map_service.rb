class MapService
  def self.get_lat_lng_by_location(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_trip_details(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['from'] = origin
      req.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['mapquest_api_key']
    end
  end
end
