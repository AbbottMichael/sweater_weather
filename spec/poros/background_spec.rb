require 'rails_helper'

RSpec.describe Background do
  it 'exists and has attributes', :vcr do
    data = BackgroundsService.get_image_by_location('denver,co')
    results = Background.new(data[:results].first)

    expect(results).to be_a(Background)
    expect(results.id).to eq("null")
    expect(results.image_urls).to be_a(Hash)
    expect(results.image_urls[:raw]).to be_a(String)
    expect(results.image_urls[:full]).to be_a(String)
    expect(results.image_urls[:regular]).to be_a(String)
    expect(results.image_urls[:small]).to be_a(String)
    expect(results.image_urls[:thumb]).to be_a(String)
    expect(results.description).to be_a(String)
    expect(results.alt_description).to be_a(String)
    expect(results.credit).to be_a(Hash)
    expect(results.credit[:name]).to be_a(String)
    expect(results.credit[:unsplash_link]).to be_a(String)
    expect(results.credit[:tag]).to be_a(String)
  end
end
