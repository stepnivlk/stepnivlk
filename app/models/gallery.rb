class Gallery < ActiveRecord::Base
  has_many :images, dependent: :destroy

  def identity
    "gallery"
  end
end
