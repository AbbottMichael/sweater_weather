class RoadTripFacade

  def self.trip_details(origin, destination, forecast)
    trip_info = RoadTripService.get_trip_details(origin, destination)
    RoadTrip.new(trip_info, forecast)
  end
end
