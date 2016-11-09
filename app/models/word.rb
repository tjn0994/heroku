class Word < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_length_word}
  validates :meaning, presence: true,
    length: {maximum: Settings.max_length_word}
  validates :lesson, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
  scope :search_name, ->name {where "name LIKE ?", "#{name}%"}
  scope :filter_lesson, ->lesson_id {where lesson_id: lesson_id}
end
