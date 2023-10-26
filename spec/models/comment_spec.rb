require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, user:, post:) }

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
