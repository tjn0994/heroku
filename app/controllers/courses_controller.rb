class CoursesController < ApplicationController
  before_action :logged_in_user, only: :show

  def show
    redirect_to lessons_path(id: params[:id])
  end
end
