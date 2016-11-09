class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :exams, dependent: :destroy
  has_many :user_lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
     foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
     foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save{self.email = email.downcase}

  mount_uploader :avatar, AvatarUploader

  scope :order_date_desc, ->{order created_at: :desc}

  validates :name, presence: true, length: {maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum:6}, allow_nil: true
  validate  :avatar_size

  enum role: [:user, :admin]

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  #def is_user? user
  #  self == user
  #end

  # Validates the size of an uploaded avatar.
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end

  # Follows a user.
  def follow other_user
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following? other_user
    following.include?(other_user)
  end

end
