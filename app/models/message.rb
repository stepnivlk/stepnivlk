class Message

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, length: { maximum: 255 }, 
        format: { with: VALID_EMAIL_REGEX }

  validates :content, presence: true, length: { maximum: 240 }

end