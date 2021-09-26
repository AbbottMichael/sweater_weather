require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends weather data pertaining to a provided location', :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body)
  end
end
