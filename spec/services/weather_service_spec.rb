require 'rails_helper'

RSpec.describe WeatherService do
  context 'class methods' do
    context '::get_weather_by_lat_lon' do
      it 'returns weather data for a given latitude and longitude', :vcr do
        search = WeatherService.get_weather_by_lat_lon(39.738453, -104.984853)
        expect(search).to be_a(Hash)
        expect(search[:current]).to be_a(Hash)
        expect(search[:current][:dt]).to be_an(Integer)
        expect(search[:current][:sunrise]).to be_an(Integer)
        expect(search[:current][:temp]).to be_a(Float)
        expect(search[:current][:feels_like]).to be_a(Float)
        expect(search[:current][:humidity]).to be_a(Numeric)
        expect(search[:current][:uvi]).to be_a(Numeric)
        expect(search[:current][:visibility]).to be_a(Numeric)
        expect(search[:current][:weather]).to be_an(Array)
        weather_current = search[:current][:weather].first
        expect(weather_current).to be_a(Hash)
        expect(weather_current[:description]).to be_a(String)
        expect(weather_current[:icon]).to be_a(String)

        expect(search[:hourly]).to be_an(Array)
        hourly = search[:hourly].first
        expect(hourly[:dt]).to be_an(Integer)
        expect(hourly[:temp]).to be_a(Float)
        expect(hourly[:weather]).to be_an(Array)
        weather_hourly = hourly[:weather].first
        expect(weather_hourly).to be_a(Hash)
        expect(weather_hourly[:description]).to be_a(String)
        expect(weather_hourly[:icon]).to be_a(String)

        expect(search[:daily]).to be_an(Array)
        daily = search[:daily].first
        expect(daily[:dt]).to be_an(Integer)
        expect(daily[:sunrise]).to be_an(Integer)
        expect(daily[:sunset]).to be_an(Integer)
        expect(daily[:temp]).to be_a(Hash)
        expect(daily[:temp][:min]).to be_a(Float)
        expect(daily[:temp][:max]).to be_a(Float)

        expect(daily[:weather]).to be_an(Array)
        weather_daily = daily[:weather].first
        expect(weather_daily).to be_a(Hash)
        expect(weather_daily[:description]).to be_a(String)
        expect(weather_daily[:icon]).to be_a(String)
      end
    end
  end
end
