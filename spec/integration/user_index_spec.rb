require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @user1 = User.create(id: 100, name: 'user1', photo: 'img1.jpg', posts_counter: 5)
    @user2 = User.create(id: 200, name: 'user2', photo: 'img2.jpg', posts_counter: 3)
  end

  it 'renders the username of all users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'renders the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src='#{@user1.photo}']")
    expect(page).to have_css("img[src='#{@user2.photo}']")
  end

  it 'renders the number of posts each user has written' do
    visit users_path
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end

  it "redirects to user1's show page clicked" do
    visit users_path
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end

  it "redirects to user2's show page clicked" do
    visit users_path
    click_link @user2.name
    expect(page).to have_current_path(user_path(@user2))
  end
end
