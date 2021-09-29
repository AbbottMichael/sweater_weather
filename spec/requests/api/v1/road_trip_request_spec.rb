require 'rails_helper'

RSpec.describe 'road trip API' do
  it 'returns travel time and destination weather if the user has a valid API key', :vcr do

    user = User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.api_keys.create!(token: SecureRandom.hex)

    body = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: user.api_keys.first[:token]
    }

    post '/api/v1/roadtrip', params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_deatils).to have_key(:data)
    expect(trip_deatils[:data]).to be_a(Hash)
    expect(trip_deatils[:data].keys.count).to eq(3)
    expect(trip_deatils[:data]).to have_key(:id)
    expect(trip_deatils[:data][:id]).to eq(nil)
    expect(trip_deatils[:data]).to have_key(:type)
    expect(trip_deatils[:data][:type]).to eq("roadtrip")
    expect(trip_deatils[:data]).to have_key(:attributes)
    expect(trip_deatils[:data][:attributes]).to be_a(Hash)
    expect(trip_deatils[:data][:attributes].keys.count).to eq(4)
  end
end
