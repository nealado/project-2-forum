class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true
end
