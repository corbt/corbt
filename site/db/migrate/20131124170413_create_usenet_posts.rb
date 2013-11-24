class CreateUsenetPosts < ActiveRecord::Migration
  def change
    create_table :usenet_posts do |t|
      t.string :author
      t.date :date
      t.boolean :corbitt
      t.text :content
      t.references :usenet_thread, index: true

      t.timestamps
    end
  end
end
