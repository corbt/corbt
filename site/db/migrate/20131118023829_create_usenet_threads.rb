class CreateUsenetThreads < ActiveRecord::Migration
  def change
    create_table :usenet_threads do |t|
      t.references :usenet_list, index: true
      t.string :thread_id
      t.string :title
      t.date :date
      t.integer :num_posts
      t.integer :num_authors
      t.integer :num_corbitt
      t.json :posts

      t.timestamps
    end
  end
end
