class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CategoriesHelper
  include SessionsHelper

  before_action :get_all_categories

  protected
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "id_not_exist"
      redirect_to users_path
    end
  end

  def verify_user
    @user = User.find_by_id params[:id]
    redirect_to root_url unless is_user? @user
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "you_do_not_have_access"
      redirect_to root_url
    end
  end

  def get_all_categories
    @categories = Category.includes(:courses).order_date_desc
  end
end
