class Book
  def initialize(data, forecast, location)
    @id = "null"
    @destination = location
    @forecast = {}
    @forecast[:summary] = forecast.current_weather[:description]
    @forecast[:temperature] = forecast.current_weather[:temperature]
    @total_books_found = data[:numFound]
    @books = []
      data[:docs].each do |doc|
        hash = {}
        hash[:isbn] = doc[:isbn]
        hash[:title] = doc[:title]
        hash[:publisher] = doc[:publisher]
        @books << hash
      end
  end
end
