class Post < ActiveRecord::Base
  include Tags
  has_many :comments

  # complete this
  def content_before_break
    content.partition(/\*{3}/)[0]
  end

  def identity
    "post"
  end
end
