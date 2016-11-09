class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.paginate(page: params[:page])
      .order_date_desc.per_page(Settings.per_page.course)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "create_success"
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "update_success"
      redirect_to admin_courses_path
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "delete_success"
    else
      flash[:warning] = t "delete_fail"
    end
    redirect_to admin_courses_path
  end

  private
    def course_params
      params.require(:course).permit :name, :category_id
    end

    def load_course
      @course = Course.find_by_id params[:id]
      if @course.nil?
        flash[:warning] = t "id_not_exist"
        redirect_to admin_courses_path
      end
    end
end
