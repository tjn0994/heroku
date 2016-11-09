class ExamsController < ApplicationController
  $k = 1
  def create_exam
     current_user.exams.create! lesson_id: params[:lesson_id]
     current_user.user_lessons.create! lesson_id: params[:lesson_id]
     redirect_to exams_path
  end

  def show
     @exam = Exam.find_by_id params[:id]

     if @exam.started?
       @results = @exam.results
     else
       @questions = @exam.lesson.questions.order("RANDOM()").limit(10)
       @exam.build_questions @questions
     end
  end

  def index
     @exams = current_user.exams.order_date_desc
  end
end
