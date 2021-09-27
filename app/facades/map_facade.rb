class MapFacade

  def self.lat_lng(location)
    coordinates = MapService.get_lat_lng_by_location(location)
    Map.new(coordinates[:results].first[:locations].first)
  end
end
