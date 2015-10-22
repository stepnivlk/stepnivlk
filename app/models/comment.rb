class Comment < ActiveRecord::Base
  belongs_to :post

  validates :author, presence: true, length: { in: 3..50 }

  validates :body, presence: true, length: { in: 10..1000 }

end
