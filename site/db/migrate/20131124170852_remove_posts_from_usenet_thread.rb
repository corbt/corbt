class RemovePostsFromUsenetThread < ActiveRecord::Migration
  def up
  	change_table :usenet_threads do |t|
  		t.remove :posts 
  	end
  end

  def down
  	change_table :usenet_threads do |t|
  		t.text :posts
  	end
  end
end
