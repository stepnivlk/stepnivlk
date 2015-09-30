class Gallery < ActiveRecord::Base
  has_many :images, dependent: :destroy
  belongs_to :user

  def random_images(count)
    images.shuffle[0...count]
  end

  def identity
    "gallery"
  end
end
