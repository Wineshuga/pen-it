require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  before do
    @user = User.create(id: 100, name: 'Me', photo: 'img1.jpg', bio: 'A teacher', posts_counter: 3)
    @user.save

    @post = @user.posts.create(title: 'Post 1', text: 'My first post', comments_counter: 2, likes_counter: 1)
    @user.reload

    visit user_posts_path(@user)
  end

  describe 'User information' do
    it 'renders the profile picture' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it 'renders the username' do
      expect(page).to have_content(@user.name)
    end

    it 'renders the number of posts' do
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end

    it 'renders the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'renders the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'renders the first comment of a post' do
      comment = Comment.create(user: @user, post: @post, text: 'This is a comment')
      comment.save
      visit user_post_path(@user, @post)
      expect(page).to have_content(comment.text)
    end

    it 'renders number of comments a post has' do
      expect(page).to have_content("Comments: #{@post.comments_counter}")
    end

    it 'renders number of likes a post has' do
      expect(page).to have_content("Likes: #{@post.likes_counter}")
    end

    it 'renders a button pagination' do
      visit user_posts_path(user_id: @user.id)
      expect(page).to have_css('.pagination-btn')
    end
  end

  describe 'Clicks on page' do
    it "redirects to post's show page clicked" do
      click_link @post.title
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
