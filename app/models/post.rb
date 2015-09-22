class Post < ActiveRecord::Base
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
end
