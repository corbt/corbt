class CreateTrafficReadings < ActiveRecord::Migration
  def change
    create_table :traffic_readings do |t|
      t.string :label
      t.text :reading

      t.timestamps
    end
  end
end
