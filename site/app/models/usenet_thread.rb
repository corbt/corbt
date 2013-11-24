class UsenetThread < ActiveRecord::Base
  belongs_to :usenet_list
  has_many :usenet_posts
end
