require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  it "is valid with valid attributes" do
    expect(post).to be_valid
  end

  it "must have a title" do
    post.title = nil
    expect(post).not_to be_valid
  end

  it "title length must be more than 250 characters" do
    post.title = 'a' * 251
    expect(post).not_to be_valid
  end

  it "comments_counter must be greater than or equal to 0" do
    post.comments_counter = 0
    expect(post).to be_valid
  end

  it "is not valid with comments_counter less than 0" do
    post.comments_counter = -1
    expect(post).not_to be_valid
  end

  it "likes_counter must be greater than or equal to 0" do
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it "is not valid with likes_counter less than 0" do
    post.likes_counter = -1
    expect(post).not_to be_valid
  end

  it "returns the 5 most recent comments" do
    comments = create_list(:comment, 10, post: post) 
    recent_comments = post.recent_comments

    expect(recent_comments.count).to eq(5)
    expect(recent_comments).to eq(comments[0..4].sort_by(&:created_at).reverse)
  end

  it "increments the author's posts_counter after save" do
    expect { post.save }.to change { user.reload.posts_counter }.by(1)
  end
end
