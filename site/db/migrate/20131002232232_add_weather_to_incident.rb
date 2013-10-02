class AddWeatherToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :weather, :text
  end
end
