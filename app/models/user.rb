class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :simple_user_infos, dependent: :destroy
  accepts_nested_attributes_for :simple_user_infos, allow_destroy: true

  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true

  has_many :educations, dependent: :destroy
  accepts_nested_attributes_for :educations, allow_destroy: true

  has_many :experiences, dependent: :destroy
  accepts_nested_attributes_for :experiences, allow_destroy: true

  has_many :posts, dependent: :destroy
  has_many :galleries, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { in: 3..50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { in: 4..150 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def age
    unless birth_date
      "N/A"
    else
      age = Date.today.year - birth_date.year
      age -= 1 if Date.today < birth_date + age.years
    end
  end
end
