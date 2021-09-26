require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends weather data pertaining to a provided location' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
