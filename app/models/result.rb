class Result < ApplicationRecord
  belongs_to :exam

  def Result.update_answer_choice question_id,exam_id,answer_id
      where("question_id=? and exam_id =?",question_id,exam_id).update_all(answer_id: answer_id)
  end
end
