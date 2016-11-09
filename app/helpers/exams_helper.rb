module ExamsHelper
  def get_correspond_question question_id
  question=Question.find_by_id question_id
  end

  def correct_answer answer_id
  answer=Answer.find_by_id answer_id
  return answer.is_correct?
  end

 def count_correct_answer

 end
end
