class RemovePostsFromUsenetThread < ActiveRecord::Migration
  def change
  	change_table :usenet_threads do |t|
  		t.remove :posts 
  	end
  end
end
