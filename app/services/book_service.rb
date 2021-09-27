class BookService
  def self.get_books_by_city(location, quantity)
    response = conn.get('/search.json') do |req|
      req.params['limit'] = quantity
      req.params['q'] = location.gsub(',', ' ')
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end
end
