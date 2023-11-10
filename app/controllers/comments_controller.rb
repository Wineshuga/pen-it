class CommentsController < ApplicationController
  load_and_authorize_resource

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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    @comment.destroy!
    flash[:success] = 'Comment was deleted successfully!'
    redirect_to user_post_path(@comment.post.author, @comment.post)
  end  

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
