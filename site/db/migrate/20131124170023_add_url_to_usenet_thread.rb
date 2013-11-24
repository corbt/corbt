class AddUrlToUsenetThread < ActiveRecord::Migration
  def change
    add_column :usenet_threads, :url, :string
  end
end
