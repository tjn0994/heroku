class Question < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: :all_blank

  validates :answers, presence: true
  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_question}
  validates :lesson, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
  scope :search_name, ->name {where "name LIKE ?", "#{name}%"}
end
