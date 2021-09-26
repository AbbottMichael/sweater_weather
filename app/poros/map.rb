class Map
  attr_reader :lat,
              :lng

  def initialize(data)
    @lat = data[:latLng][:lat]
    @lng = data[:latLng][:lng]
  end
end
