class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :word

  validates :word, presence: true
  validates :question, presence: true
  validates :is_correct, inclusion: {in: [true, false]}
end
