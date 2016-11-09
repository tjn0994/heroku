class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "login_success"
      params[:session][:remember_me] == Settings.remember_value ? remember(user) : forget(user)
      if user.admin?
          redirect_to admin_root_path
      else
        redirect_to user
      end
    else
      flash.now[:danger] = t "login_unsuccess"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
