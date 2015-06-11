class CommentsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment].permit(:body))
    @comment.author = current_user
    if @comment.save
      redirect_to :back, notice: "Your comment has been published"
    else
      flash.alert = "Your comment could not be published. Comments can't be blank."
      render :new
    end
  end

end
