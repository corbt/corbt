class AddThreadsCountToUsenetList < ActiveRecord::Migration
  def change
    add_column :usenet_lists, :threads_count, :integer
  end
end
