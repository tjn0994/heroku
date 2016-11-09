class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :load_user, only: [:show, :edit, :update]
  before_action :verify_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.order_date_desc.paginate page: params[:page],
      per_page: Settings.per_page.user
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "sign_up_success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    User.find_by_id(params[:id]).destroy
    flash[:success] = t "user_deleted"
    redirect_to users_url
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def feed
      #Entry.where("user_id IN (?) OR user_id = ?", following_ids, id)
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Entry.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)

  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_digest, :avatar
  end
end
