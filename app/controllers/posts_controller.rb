class PostsController < ApplicationController
  before_filter :load_post
  before_filter :load_user, except: [:new, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @posts = @user.posts.order("created_at").page(params[:page]).per(PER_PAGE)
  end

  def create
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path(current_user), notice: "Your knowledge has been published"
    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end

  def show
    @comments = @post.comments.all
    @comment = Comment.new
  end

  private

  def load_post
    if params[:id].present?
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end

    if params[:post].present?
      @post.assign_attributes(post_params)
    end
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
