require 'rails_helper'

RSpec.describe 'backgrounds API' do
  it 'sends weather data pertaining to a provided location', :vcr do
    location = 'denver,co'
    get "/api/v1/backgrounds?location=#{location}"

    expect(response).to be_successful
  end
end
