class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
  has_many :images, through: :taggings

  def to_s
    name
  end

end
