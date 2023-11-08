class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @posts = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = User.find(params[:user_id])
    @post.likes_counter = 0
    @post.comments_counter = 0

    if @post.save
      flash[:notice] = 'Post created successfully!'
      redirect_to user_posts_path(id: @post.id)
    else
      flash[:alert] = 'Error: could not create a new post'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
