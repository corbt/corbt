class AddRegionToTrafficReading < ActiveRecord::Migration
  def change
    add_column :traffic_readings, :region, :string
  end
end
