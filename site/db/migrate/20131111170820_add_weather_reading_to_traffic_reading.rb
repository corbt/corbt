class AddWeatherReadingToTrafficReading < ActiveRecord::Migration
  def change
    add_reference :traffic_readings, :weather_reading, index: true
  end
end
