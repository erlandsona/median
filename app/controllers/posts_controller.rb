class PostsController < ApplicationController
  before_action :load_post
  before_action :load_user, except: [:new, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @posts = @user.posts.order("created_at").page(params[:page]).per(PER_PAGE)
    unless @user == current_user
      @posts = @posts.published
    end
  end

  def create
    @post.author = current_user
    if @post.save
      if params[:commit] == "Save As Draft"
        message = "Your draft has been saved."

      else
        message = "Your knowledge has been published."
        @post.publish!
      end
      redirect_to user_posts_path(current_user), notice: message

    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end

  def show
    if @post.draft? && @post.author != current_user
      flash.alert = "You do not have permission to access that page."
      redirect_to root_path
    end
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
    params.require(:post).permit(:title, :body, :image, :all_tags)
  end
end
