class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = "null"
    @timezone_offset = data[:timezone_offset]
    @current_weather = {}
    @current_weather[:datetime] = format_date_time(data[:current][:dt])
    @current_weather[:sunrise] = format_date_time(data[:current][:sunrise])
    @current_weather[:sunset] = format_date_time(data[:current][:sunset])
    @current_weather[:temperature] = data[:current][:temp]
    @current_weather[:feels_like] = data[:current][:temp]
    @current_weather[:humidity] = data[:current][:humidity]
    @current_weather[:uvi] = data[:current][:uvi]
    @current_weather[:visibility] = data[:current][:visibility]
    @current_weather[:description] = data[:current][:weather].first[:description]
    @current_weather[:icon] = data[:current][:weather].first[:icon]
    @daily_weather = []
      data[:daily][1..5].each do |day|
        hash = {}
        hash[:date] = format_date(day[:dt])
        hash[:sunrise] = format_date_time(day[:sunrise])
        hash[:sunset] = format_date_time(day[:sunset])
        hash[:max_temp] = day[:temp][:max]
        hash[:min_temp] = day[:temp][:min]
        hash[:conditions] = day[:weather].first[:description]
        hash[:icon] = day[:weather].first[:icon]
        @daily_weather << hash
      end
    @hourly_weather = []
      data[:hourly][0..7].each do |hour|
        hash = {}
        hash[:time] = format_time((data[:current][:dt]) + hour[:dt])
        hash[:temperature] = hour[:temp]
        hash[:conditions] = hour[:weather].first[:description]
        hash[:icon] = hour[:weather].first[:icon]
        @hourly_weather << hash
      end
  end

  def format_date_time(date_time)
    to_date_time(date_time).strftime('%F %T')
  end

  def format_date(date)
    to_date_time(date).strftime('%F')
  end

  def format_time(time)
    to_date_time(time).strftime('%T')
  end

  def to_date_time(input)
    converted = (input + @timezone_offset).to_s
    DateTime.strptime(converted,'%s')
  end
end
