require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(id: 100, name: 'Me', photo: 'img1.jpg', bio: 'A teacher', posts_counter: 3)
    @user.save

    @post = Post.create(title: 'Post 1', text: 'My first post', author: @user, comments_counter: 2, likes_counter: 1)
    @post.save

    @comment1 = Comment.create(post: @post, text: 'First Comment', user: @user)
    @comment2 = Comment.create(post: @post, text: 'Second Comment', user: @user)

    visit user_post_path(@user, @post)
  end

  describe 'User information' do
    it "renders the Post's title" do
      expect(page).to have_content(@post.title)
    end

    it 'renders the name of writer' do
      expect(page).to have_content(@post.author.name)
    end

    it 'renders number of comments a post has' do
      expect(page).to have_content("Comments: #{@post.comments_counter}")
    end

    it 'renders number of likes a post has' do
      expect(page).to have_content("Likes: #{@post.likes_counter}")
    end

    it 'renders the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'renders the username of each commentor' do
      expect(page).to have_content(@comment1.user.name)
      expect(page).to have_content(@comment2.user.name)
    end

    it 'renders the comment text of each commentor' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
  end
end
