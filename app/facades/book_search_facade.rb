class BookSearchFacade

  def self.books_by_city(forecast, location, quantity)
    weather = []
    weather << forecast.current_weather[:description]
    weather << forecast.current_weather[:temperature]
    data = BookService.get_books_by_city(location, quantity)
    Book.new(data, weather, location)
  end
end
