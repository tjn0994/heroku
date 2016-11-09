class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_question, except: [:index, :create, :show]
  before_action :load_lesson, except: :show
  before_action :load_word, only: [:index, :create, :edit]

  def index
    list_question
    @question = @lesson.questions.new
    @answer = @question.answers.build
  end

  def create
    @question = @lesson.questions.new question_params
    if @question.save
      flash[:success] = t "create_success"
      redirect_to admin_lesson_questions_path
    else
      list_question
      render :index
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "update_success"
      redirect_to admin_lesson_questions_path
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = "delete success"
    else
      flash[:warning] = "delete not success"
    end
    redirect_to admin_lesson_questions_path
  end

  private
  def question_params
    params.require(:question).permit(:name,
      answers_attributes: [:id, :word_id, :is_correct, :_destroy])
  end

  def list_question
    @questions = @lesson.questions.search_name(params[:search])
      .order_date_desc.paginate page: params[:page],
      per_page: Settings.per_page.question
  end

  def load_question
    @question = Question.find_by_id params[:id]
    unless @question
      flash[:warning] = t "id_not_exist"
      redirect_to admin_lesson_questions_path
    end
  end

  def load_lesson
    @lesson = Lesson.find_by_id params[:lesson_id]
    unless @lesson
      flash[:warning] = t "lesson_id_not_exist"
      redirect_to admin_lessons_path
    end
  end

  def load_word
    @words = Word.filter_lesson(@lesson)
  end
end
