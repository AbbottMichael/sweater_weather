class Book
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id

  def initialize(data, weather, location)
    @id = "null"
    @destination = location
    @forecast = {}
    @forecast[:summary] = weather[0]
    @forecast[:temperature] = weather[1].to_s + " F"
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
