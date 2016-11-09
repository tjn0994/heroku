class Lesson < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :exam, dependent: :destroy
  has_many :user_lessons, dependent: :destroy
  has_many :words, dependent: :destroy
  belongs_to :course

  scope :order_date_desc, ->{order created_at: :desc}
  scope :filter_course, ->course_id {where course_id: course_id}

  mount_uploader :image, ImageUploader

  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_lesson}
  validates :image, presence: true
  validate :verify_image_size

  private
    def verify_image_size
      if image.size > Settings.image_size.megabytes
        errors.add :image, t("error_image")
      end
    end
end
