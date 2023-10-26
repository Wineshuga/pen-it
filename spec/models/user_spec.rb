require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Charles', post_counter: 2, photo: 'https://google.photos.com', bio: 'Educator in Australia') }

  before { subject.save }
  
  describe '#validates' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not_be_valid
    end

    it 'post_counter should be an integer' do
      subject.post_counter = 'five'
      expect(subject).to_not_be_valid
    end

    it 'post_counter should be greater than or equal to 0' do
      subject.post_counter = -2
      expect(subject).to_not_be_valid
    end
 end
 
 describe '#recent_posts' do
    it 'should return last 3 posts' do

      user = User.create(name: 'Charles', photo: 'https://google.photos.com', bio: 'Educator in Australia')

      first_post = user.posts.create(title: 'Post 1', text: 'Content 1', created_at: 3.days.ago)
      second_post = user.posts.create(title: 'Post 2', text: 'Content 2', created_at: 2.days.ago)
      third_post = user.posts.create(title: 'Post 3', text: 'Content 3', created_at: 1.day.ago)
      fourth_post = user.posts.create(title: 'Post 4', text: 'Content 4', created_at: Time.now)

      recent_posts = user.recent_posts

      expect(recent_posts.length).to eq(3)
    end
  end
end
