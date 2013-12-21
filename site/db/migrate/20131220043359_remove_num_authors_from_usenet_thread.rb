class RemoveNumAuthorsFromUsenetThread < ActiveRecord::Migration
	def up
		change_table :usenet_threads do |t|
			t.remove :num_authors 
		end
	end

	def down
		change_table :usenet_threads do |t|
			t.integer :num_authors
		end
	end
end
