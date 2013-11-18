class CreateUsenetLists < ActiveRecord::Migration
  def change
    create_table :usenet_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
