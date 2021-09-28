class BackgroundsService
  def self.get_image_by_location(location)
    response = conn.get('/search/photos') do |req|
      req.params['query'] = location
      req.params['per_page'] = 1
      req.params['orientation'] = 'landscape'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['unsplash_api_key']
    end
  end
end
