class Post < ActiveRecord::Base
  include Tags

  # complete this
  def content_before_break
    content.partition(/\*{3}/)[0]
  end
end
