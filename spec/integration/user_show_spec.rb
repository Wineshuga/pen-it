require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(id: 100, name: 'Me', photo: 'img1.jpg', bio: 'A teacher', posts_counter: 1)
    @user.save

    @post1 = Post.create(title: 'Post 1', text: 'My first post', author: @user, comments_counter: 2, likes_counter: 1)
    @post2 = Post.create(title: 'Post 2', text: 'My second post', author: @user, comments_counter: 2, likes_counter: 1)
    @post3 = Post.create(title: 'Post 3', text: 'My third post', author: @user, comments_counter: 2, likes_counter: 1)

    visit user_path(@user)
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

    it "renders user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it 'renders the first 3 posts of the user' do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end
  end

  describe 'Clicks on page' do
    it "renders a button to see all user's posts" do
      expect(page).to have_content('See all posts')
      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end

    it "redirects to post's index page" do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user))
    end

    it "redirects to post's show page clicked" do
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end
  end
end
