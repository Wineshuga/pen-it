class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
    if @like.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      flash[:alert] = 'Error: could not add like'
      render :new
    end
  end
end
