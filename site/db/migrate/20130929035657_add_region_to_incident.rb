class AddRegionToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :region, :string
    Incident.update_all(region: "london")
  end
end
