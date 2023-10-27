require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'tom.jpg', bio: 'Tom\'s bio', posts_counter: 0) }
  let(:subject) { Post.new(author: user, title: 'My first post', text: 'post', comments_counter: 0, likes_counter: 0) }

  describe 'validations' do
    before { subject.save }

    it 'is valid with the required attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid when comments_counter is not an integer' do
      subject.comments_counter = 'a'
      expect(subject).not_to be_valid
    end

    it 'is not valid when comments_counter is less than zero' do
      subject.comments_counter = -10
      expect(subject).not_to be_valid
    end

    it 'is not valid when likes_counter is not an integer' do
      subject.likes_counter = 'a'
      expect(subject).not_to be_valid
    end

    it 'is not valid when likes_counter is less than zero' do
      subject.likes_counter = -1
      expect(subject).not_to be_valid
    end
  end
  describe 'methods' do
    it 'updates posts_counter' do
      subject.send(:update_posts_counter)
      expect(user.posts_counter).to eq(1)
    end

    it 'returns recent comments' do
      6.times do
        Comment.create(user:, post: subject, text: 'This is the comment')
      end
      comments = subject.recent_comments
      expect(comments.length).to eq(5)
    end
  end
end
