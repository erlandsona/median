class UsersController < ApplicationController
  before_action :load_user, except: [:index, :edit, :update]

  def index
    @users = User.order("name").page(params[:page]).per(PER_PAGE)
  end

  def edit
    if !current_user
      redirect_to root_path
    else
       @user = current_user
    end
  end

  def create
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      auto_login(@user)
      redirect_to root_path, notice: "Welcome, #{@user.name}"
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to user_posts_path(@user)
      flash.notice = "Your profile has been updated"
    else
      flash.alert = "Please fix the errors below to continue"
      render :edit
    end
  end

  protected

  def load_user
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = User.new
    end
    if params[:user].present?
      @user.assign_attributes(user_params)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :bio, :password, :password_confirmation)
  end
end
