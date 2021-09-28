require 'rails_helper'

RSpec.describe 'backgrounds API' do
  it 'returns the url of an appropriate background image for the provided location', :vcr do
    location = 'denver,co'
    get "/api/v1/backgrounds?location=#{location}"

    expect(response).to be_successful

    backgrounds = JSON.parse(response.body, symbolize_names: true)

    expect(backgrounds).to have_key(:data)
    expect(backgrounds[:data]).to be_a(Hash)
    expect(backgrounds[:data].keys.count).to eq(3)
    expect(backgrounds[:data]).to have_key(:id)
    expect(backgrounds[:data][:id]).to eq("null")
    expect(backgrounds[:data]).to have_key(:type)
    expect(backgrounds[:data][:type]).to eq("backgrounds")
    expect(backgrounds[:data]).to have_key(:attributes)
    expect(backgrounds[:data][:attributes]).to be_a(Hash)
    expect(backgrounds[:data][:attributes].keys.count).to eq(4)
    expect(backgrounds[:data][:attributes]).to have_key(:image_urls)

    image_urls = backgrounds[:data][:attributes][:image_urls]
    expect(image_urls).to be_a(Hash)
    expect(image_urls).to have_key(:raw)
    expect(image_urls[:raw]).to be_a(String)
    expect(image_urls).to have_key(:full)
    expect(image_urls[:full]).to be_a(String)
    expect(image_urls).to have_key(:regular)
    expect(image_urls[:regular]).to be_a(String)
    expect(image_urls).to have_key(:small)
    expect(image_urls[:small]).to be_a(String)
    expect(image_urls).to have_key(:thumb)
    expect(image_urls[:thumb]).to be_a(String)

    expect(backgrounds[:data][:attributes]).to have_key(:description)
    expect(backgrounds[:data][:attributes][:description]).to be_a(String)
    expect(backgrounds[:data][:attributes]).to have_key(:alt_description)
    expect(backgrounds[:data][:attributes][:alt_description]).to be_a(String)
    expect(backgrounds[:data][:attributes]).to have_key(:credit)
    expect(backgrounds[:data][:attributes][:credit]).to be_a(Hash)
    expect(backgrounds[:data][:attributes][:credit].count).to eq(3)

    credit = backgrounds[:data][:attributes][:credit]
    expect(credit).to have_key(:name)
    expect(credit[:name]).to be_a(String)
    expect(credit).to have_key(:unsplash_link)
    expect(credit[:unsplash_link]).to be_a(String)
    expect(credit).to have_key(:tag)
    expect(credit[:tag]).to be_a(String)
  end
end
