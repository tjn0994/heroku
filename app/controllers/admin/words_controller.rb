class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_word, except: [:index, :create]
  before_action :load_lesson, except: :show

  def index
    list_word
    @word = @lesson.words.new
  end

  def create
    @word = @lesson.words.new word_params
    if @word.save
      flash[:success] = t "create_success"
      redirect_to admin_lesson_words_path
    else
      list_word
      render :index
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "update_success"
      redirect_to admin_lesson_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = "delete success"
    else
      flash[:warning] = "delete not success"
    end
    redirect_to admin_lesson_words_path
  end

  private
  def word_params
    params.require(:word).permit :name, :meaning
  end

  def load_word
    @word = Word.find_by_id params[:id]
    unless @word
      flash[:warning] = t "id_not_exist"
      redirect_to admin_lesson_words_path
    end
  end

  def list_word
    @words = @lesson.words.search_name(params[:search]).order_date_desc
      .paginate page: params[:page], per_page: Settings.per_page.word
  end

  def load_lesson
    @lesson = Lesson.find_by_id params[:lesson_id]
    unless @lesson
      flash[:warning] = t "lesson_id_not_exist"
      redirect_to admin_lessons_path
    end
  end
end
