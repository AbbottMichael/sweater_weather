class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(trip_info, forecast, origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = format_time(trip_info[:route][:realTime])
    return if @travel_time == 'impossible'
    @weather_at_eta = {}
    hour = forecast.hourly_weather[hours_ahead(trip_info[:route][:realTime])]
    @weather_at_eta[:temperature] = hour[:temperature]
    @weather_at_eta[:conditions] = hour[:conditions]
  end

  def format_time(time)
    return 'impossible' if time.nil?
    Time.at(time).utc.strftime("%H:%M")
  end

  def hours_ahead(trip_seconds)
    hours = (((trip_seconds / 3600.0).round) - 1)
    return 0 if (hours <= 0)
    return 7 if (hours >= 8)
  end
end
