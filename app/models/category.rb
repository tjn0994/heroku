class Category < ApplicationRecord
  has_many :courses, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}
  scope :order_date_desc, ->{order created_at: :desc}
end
