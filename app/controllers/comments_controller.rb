class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user = User.find(params[:user_id])
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_posts_path(user_id: @post.author, id: @post.id)
    else
      flash[:alert] = 'Error: could not create comment'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end