class Comment < ActiveRecord::Base
  belongs_to :post

  validates :author, presence: true, length: { in: 3..50 }
end
