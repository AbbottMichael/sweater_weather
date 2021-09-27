class BookSearchFacade

  def self.books_by_city(forecast, location, quantity)
    data = BookService.get_books_by_city(location, quantity)
    Book.new(data, forecast, location)
  end
end
