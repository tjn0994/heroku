class ResultsController < ApplicationController
include ExamsHelper
  def create
     hash_of_question_answer=Hash.new
     hash_of_question_answer=params[:answer]

     exam_id=params[:exam_id]
     exam=Exam.find_by_id exam_id
     number_of_answer=0
     number_of_correct_answer=0
     unless hash_of_question_answer.nil?
      hash_of_question_answer.each do |quesion_id,answer_id|
        if !quesion_id.nil?
          number_of_answer +=1
          if correct_answer answer_id
            number_of_correct_answer+=1
         end
      end
        Result.update_answer_choice quesion_id,exam.id,answer_id
      end
      exam.update_status
      exam.update_score number_of_correct_answer
      exam.update_done_question number_of_answer
      end
     redirect_to exams_path
  end
end
