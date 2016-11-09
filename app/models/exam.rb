class Exam < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  has_many :learned_words, dependent: :destroy
  has_many :results
  enum status: {not_started: 0, started: 1}

  scope :order_date_desc, ->{order created_at: :desc}

  def update_status
    if self.not_started?
      self.started!
    end
  end

  def build_questions questions
    questions.each do |question|
    self.results.create question_id: question.id
   end
  end

  def update_score score
    self.update_columns(score:score)
  end

  def update_done_question done_question
   self.update_columns(done_question: done_question)
  end
end
