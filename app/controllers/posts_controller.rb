class PostsController < ApplicationController
  before_filter :load_post
  before_action :require_login

  def create
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path(current_user), notice: "Your knowledge has been published"
    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end

  private

  def load_post
    @post = Post.new
    if params[:post].present?
      @post.assign_attributes(post_params)
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
