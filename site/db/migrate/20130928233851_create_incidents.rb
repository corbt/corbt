class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.text :blob
      t.integer :incidentId

      t.timestamps
    end
  end
end
