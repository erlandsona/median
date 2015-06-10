class CommentsController < ApplicationController

  def index
    @comments = @post.comments.all
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    if @comment.save
      redirect_to root_path, notice: "Your comment has been published"
    else
      flash.alert = "Your comment could not be published. Please correct the errors below."
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
