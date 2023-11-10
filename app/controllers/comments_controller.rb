class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_posts_path(user_id: @post.author, id: @post.id)
    else
      flash[:alert] = 'Error: could not create comment'
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    @comment.destroy!
    flash[:success] = 'Comment was deleted successfully!'
    redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
