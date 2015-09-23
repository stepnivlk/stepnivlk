class Post < ActiveRecord::Base
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  def content_before_break
    content.partition(/\*{3}/)[0]
  end
end
