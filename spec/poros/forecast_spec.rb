require 'rails_helper'

RSpec.describe Map do
  it 'exists and has attributes', :vcr do
    data = ForecastService.get_forecast_by_lat_lon(39.738453, -104.984853)
    results = Forecast.new(data)

    expect(results).to be_a(Forecast)
    expect(results.id).to eq("null")
    expect(results.current_weather).to be_a(Hash)
    expect(results.current_weather[:datetime]).to eq("2021-09-26 22:14:25")
    expect(results.current_weather[:sunrise]).to eq("2021-09-26 06:51:34")
    expect(results.current_weather[:sunset]).to eq("2021-09-26 18:50:40")
    expect(results.current_weather[:temperature]).to eq(67.93)
    expect(results.current_weather[:feels_like]).to eq(67.93)
    expect(results.current_weather[:humidity]).to eq(25)
    expect(results.current_weather[:uvi]).to eq(0)
    expect(results.current_weather[:visibility]).to eq(10000)
    expect(results.current_weather[:description]).to eq("overcast clouds")
    expect(results.current_weather[:icon]).to eq("04n")

    expect(results.daily_weather).to be_an(Array)
    expect(results.daily_weather.count).to eq(5)
    day = results.daily_weather.first
    expect(day).to be_a(Hash)
    expect(day[:date]).to eq("2021-09-27")
    expect(day[:sunrise]).to eq("2021-09-27 06:52:30")
    expect(day[:sunset]).to eq("2021-09-27 18:49:02")
    expect(day[:max_temp]).to eq(87.08)
    expect(day[:min_temp]).to eq(66.65)
    expect(day[:conditions]).to eq("broken clouds")
    expect(day[:icon]).to eq("04d")

    expect(results.hourly_weather).to be_an(Array)
    expect(results.hourly_weather.count).to eq(8)
    hour = results.hourly_weather.first
    expect(hour).to be_a(Hash)
    expect(hour[:time]).to eq("02:14:25")
    expect(hour[:temperature]).to eq(67.93)
    expect(hour[:conditions]).to eq("overcast clouds")
    expect(hour[:icon]).to eq("04n")
  end
end
