class Tagging < ActiveRecord::Base
  belongs_to :post
  belongs_to :image
  belongs_to :tag
  
end
