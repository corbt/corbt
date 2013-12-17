class UsenetThread < ActiveRecord::Base
  belongs_to :usenet_list, counter_cache: :threads_count
  has_many :usenet_posts

  validates_uniqueness_of :title, scope: [:usenet_list_id, :date, :num_corbitt, :num_posts]
end
