require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends weather data pertaining to a provided location', :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to be_a(Hash)
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq("null")
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq("forecast")
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    current = forecast[:data][:attributes][:current_weather]

    expect(current).to be_a(Hash)
    expect(current).to have_key(:datetime)
    expect(current[:datetime]).to be_a(String)
    expect(current).to have_key(:sunrise)
    expect(current[:sunrise]).to be_a(String)
    expect(current).to have_key(:sunset)
    expect(current[:sunset]).to be_a(String)
    expect(current).to have_key(:temperature)
    expect(current[:temperature]).to be_a(Numeric)
    expect(current).to have_key(:feels_like)
    expect(current[:feels_like]).to be_a(Numeric)
    expect(current).to have_key(:humidity)
    expect(current[:humidity]).to be_a(Numeric)
    expect(current).to have_key(:uvi)
    expect(current[:uvi]).to be_a(Numeric)
    expect(current).to have_key(:visibility)
    expect(current[:visibility]).to be_a(Numeric)
    expect(current).to have_key(:description)
    expect(current[:description]).to be_a(String)
    expect(current).to have_key(:icon)
    expect(current[:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
    day = forecast[:data][:attributes][:daily_weather].first
    expect(day).to have_key(:date)
    expect(day[:date]).to be_a(String)
    expect(day).to have_key(:sunrise)
    expect(day[:sunrise]).to be_a(String)
    expect(day).to have_key(:max_temp)
    expect(day[:max_temp]).to be_a(Numeric)
    expect(day).to have_key(:min_temp)
    expect(day[:min_temp]).to be_a(Numeric)
    expect(day).to have_key(:min_temp)
    expect(day[:min_temp]).to be_a(Numeric)
    expect(day).to have_key(:conditions)
    expect(day[:conditions]).to be_a(String)
    expect(day).to have_key(:icon)
    expect(day[:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:hourly_weather].count).to eq(8)
    hour = forecast[:data][:attributes][:hourly_weather].first
    expect(hour).to have_key(:time)
    expect(hour[:time]).to be_a(String)
    expect(hour).to have_key(:temperature)
    expect(hour[:temperature]).to be_a(Numeric)
    expect(hour).to have_key(:conditions)
    expect(hour[:conditions]).to be_a(String)
    expect(hour).to have_key(:icon)
    expect(hour[:icon]).to be_a(String)
  end
end
