class Post < ActiveRecord::Base
  include Tags
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { in: 3..50 }
  validates :content, presence: true

  # complete this
  def content_before_break
    content.partition(/\*{3}/)[0]
  end

  def identity
    "post"
  end
end
