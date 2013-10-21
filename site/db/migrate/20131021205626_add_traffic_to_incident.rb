class AddTrafficToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :traffic, :text
  end
end
