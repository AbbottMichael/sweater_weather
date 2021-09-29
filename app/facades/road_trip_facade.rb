class RoadTripFacade

  def self.trip_details(origin, destination, forecast)
    trip_info = MapService.get_trip_details(origin, destination)
    RoadTrip.new(trip_info, forecast, origin, destination)
  end
end
