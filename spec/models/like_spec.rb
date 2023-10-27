require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'tom.jpg', bio: 'Tom\'s bio', posts_counter: 0) }
  let(:post) { Post.new(author: user, title: 'My first post', text: 'post', comments_counter: 0, likes_counter: 0) }
  let(:like) { Like.new(user:, post:) }

  before { post.save }

  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end

  it 'belongs to a user' do
    expect(like.user).to eq(user)
  end

  it 'belongs to a post' do
    expect(like.post).to eq(post)
  end

  it 'increments the likes_counter of the associated post after save' do
    expect { like.save }.to change { post.reload.likes_counter }.by(1)
  end
end
