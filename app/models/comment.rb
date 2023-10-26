class Comment < ApplicationRecord
  belongs_to :users, class_name: 'User', foreign_key: 'user_id'
  belongs_to :posts, class_name: 'Post', foreign_key: 'post_id'

  after_create :update_comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
