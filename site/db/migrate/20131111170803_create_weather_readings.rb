class CreateWeatherReadings < ActiveRecord::Migration
  def change
    create_table :weather_readings do |t|
      t.text :reading
      t.string :label

      t.timestamps
    end
  end
end
