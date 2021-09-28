class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image_urls,
             :description,
             :alt_description,
             :credit
end
