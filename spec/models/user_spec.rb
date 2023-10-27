require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Charles', photo: 'https://google.photos.com', bio: 'Educator in Australia', posts_counter: 2 ) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'five'
    expect(subject).not_to be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -2
    expect(subject).not_to be_valid
  end

  it 'should return last 3 posts' do
    5.times do
      Post.create(author: subject, title: 'My first post', text: 'post', comments_counter: 0, likes_counter: 0)
    end
    returned_posts = subject.recent_posts
    expect(returned_posts.length).to eq(3)
  end
end
