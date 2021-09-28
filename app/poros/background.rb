class Background
  attr_reader :id,
              :image_urls,
              :description,
              :alt_description,
              :credit

  def initialize(data)
    @id = "null"
    @image_urls = data[:urls]
    @description = data[:description].nil? ? 'not available' : data[:description]
    @alt_description = data[:description].nil? ? 'not available' : data[:alt_description]
    @credit = {}
    @credit[:name] = data[:user][:name]
    @credit[:unsplash_link] = data[:user][:links][:html]
    @credit[:tag] = 'Photo from Unsplash by'
  end
end
