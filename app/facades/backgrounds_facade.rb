class BackgroundsFacade

  def self.image_by_location(location)
    image_data = BackgroundsService.get_image_by_location(location)
    Background.new(image_data[:results].first)
  end
end
