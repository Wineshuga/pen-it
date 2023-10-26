require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { create(:like, user: user, post: post) }

  it "is valid with valid attributes" do
    expect(like).to be_valid
  end

  it "belongs to a user" do
    expect(like.user).to eq(user)
  end

  it "belongs to a post" do
    expect(like.post).to eq(post)
  end

  it "increments the likes_counter of the associated post after save" do
    expect { like.save }.to change { post.reload.likes_counter }.by(1)
  end
end
