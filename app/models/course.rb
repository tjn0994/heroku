class Course < ApplicationRecord
  belongs_to :category
  has_many :lessons, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}
  scope :order_date_desc, ->{order created_at: :desc}
end
