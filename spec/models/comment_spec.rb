require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'tom.jpg', bio: 'Tom\'s bio', posts_counter: 0) }
  let(:post) { Post.new(author: user, title: 'My first post', text: 'post', comments_counter: 0, likes_counter: 0) }
  let(:comment) { Comment.new(user:, post:, text: 'comments') }

  before { post.save }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'belongs to a user' do
    expect(comment.user).to eq(user)
  end

  it 'belongs to a post' do
    expect(comment.post).to eq(post)
  end

  it 'increments the comments_counter of the associated post after save' do
    expect { comment.save }.to change { post.reload.comments_counter }.by(1)
  end
end
