class CommentsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.author = current_user
    if @comment.save
      redirect_to :back, notice: "Your comment has been published"
    else
      flash.alert = "Your comment could not be published. Please correct the errors below."
      render "posts/show"
    end
  end

end
