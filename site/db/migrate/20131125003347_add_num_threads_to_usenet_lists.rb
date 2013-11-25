class AddNumThreadsToUsenetLists < ActiveRecord::Migration
  def change
    add_column :usenet_lists, :num_threads, :integer
  end
end
