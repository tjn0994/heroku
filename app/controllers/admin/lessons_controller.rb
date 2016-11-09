class Admin::LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_lesson, except: [:index, :new, :create]
  before_action :list_course, only: [:edit, :new]

  def index
    @lessons = Lesson.includes(:course).order_date_desc
      .paginate page: params[:page], per_page: Settings.per_page.lesson
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:success] = t "create_success"
      redirect_to admin_lessons_path
    else
      list_course
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "update_success"
      redirect_to admin_lessons_path
    else
      list_course
      render :edit
    end
  end

  def show
  end

  def destroy
    if @lesson.destroy
      flash[:success] = t "delete_success"
    else
      flash[:warning] = t "delete_fail"
    end
    redirect_to admin_lessons_path
  end

  private
    def lesson_params
      params.require(:lesson).permit :name, :course_id, :image
    end

    def load_lesson
      @lesson = Lesson.find_by_id params[:id]
      if @lesson.nil?
        flash[:warning] = t "id_not_exist"
        redirect_to admin_lessons_path
      end
    end

    def list_course
      @courses = Course.all
    end
end
