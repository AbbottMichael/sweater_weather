require 'rails_helper'

RSpec.describe 'road trip API' do
  before :each do
    @user = User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    @user.api_keys.create!(token: SecureRandom.hex)
  end

  it 'returns travel time and destination weather if the user has a valid API key', :vcr do
    body = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: @user.api_keys.first[:token]
    }

    post '/api/v1/road_trip', params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_details).to have_key(:data)
    expect(trip_details[:data]).to be_a(Hash)
    expect(trip_details[:data].keys.count).to eq(3)
    expect(trip_details[:data]).to have_key(:id)
    expect(trip_details[:data][:id]).to eq(nil)
    expect(trip_details[:data]).to have_key(:type)
    expect(trip_details[:data][:type]).to eq("roadtrip")
    expect(trip_details[:data]).to have_key(:attributes)
    expect(trip_details[:data][:attributes]).to be_a(Hash)
    expect(trip_details[:data][:attributes].keys.count).to eq(4)

    attributes = trip_details[:data][:attributes]
    expect(attributes).to have_key(:start_city)
    expect(attributes[:start_city]).to be_a(String)
    expect(attributes).to have_key(:end_city)
    expect(attributes[:end_city]).to be_a(String)
    expect(attributes).to have_key(:travel_time)
    expect(attributes[:travel_time]).to eq('impossible')
    expect(attributes).to have_key(:weather_at_eta)
    expect(attributes[:weather_at_eta]).to be_a(Hash)
    expect(attributes[:weather_at_eta].keys.count).to eq(2)
    expect(attributes[:weather_at_eta][:temperature]).to be_a(Numeric)
    expect(attributes[:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'returns an error if origin is missing', :vcr do
    body = {
      destination: "Pueblo,CO",
      api_key: @user.api_keys.first[:token]
    }

    post '/api/v1/road_trip', params: body, as: :json

    expect(response.status).to eq(400)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_details).to have_key(:error)
    expect(trip_details[:error]).to eq("Must provide an origin and a destination")
  end

  it 'returns an error if destination is missing', :vcr do
    body = {
      origin: "Denver,CO",
      api_key: @user.api_keys.first[:token]
    }

    post '/api/v1/road_trip', params: body, as: :json

    expect(response.status).to eq(400)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_details).to have_key(:error)
    expect(trip_details[:error]).to eq("Must provide an origin and a destination")
  end

  it 'returns an error if the api key is not found in the database', :vcr do
    body = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: "1234"
    }

    post '/api/v1/road_trip', params: body, as: :json

    expect(response.status).to eq(401)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_details).to have_key(:error)
    expect(trip_details[:error]).to eq("Not authorized. Please provide a valid API key")
  end

  it 'returns an error if the route is impossible', :vcr do
    body = {
      origin: "Denver,CO",
      destination: "London,UK",
      api_key: @user.api_keys.first[:token]
    }

    post '/api/v1/road_trip', params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    trip_details = JSON.parse(response.body, symbolize_names: true)

    expect(trip_details).to have_key(:data)
    expect(trip_details[:data]).to be_a(Hash)
    expect(trip_details[:data].keys.count).to eq(3)
    expect(trip_details[:data]).to have_key(:id)
    expect(trip_details[:data][:id]).to eq(nil)
    expect(trip_details[:data]).to have_key(:type)
    expect(trip_details[:data][:type]).to eq("roadtrip")
    expect(trip_details[:data]).to have_key(:attributes)
    expect(trip_details[:data][:attributes]).to be_a(Hash)
    expect(trip_details[:data][:attributes].keys.count).to eq(4)

    attributes = trip_details[:data][:attributes]
    expect(attributes).to have_key(:start_city)
    expect(attributes[:start_city]).to be_a(String)
    expect(attributes).to have_key(:end_city)
    expect(attributes[:end_city]).to be_a(String)
    expect(attributes).to have_key(:travel_time)
    expect(attributes[:travel_time]).to eq('impossible')
    expect(attributes).to have_key(:weather_at_eta)
    expect(attributes[:weather_at_eta]).to eq(nil)

  end
end
