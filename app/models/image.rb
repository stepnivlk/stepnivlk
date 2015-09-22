class Image < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :file, styles: { original: "1200x1200>", medium: "600>x600", thumb: "x200>" }
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

    def prev
    prev_item = Image.where("id < ?", id).last
    return prev_item if prev_item && prev_item.gallery_id == gallery_id
  end

  def next
    next_item = Image.where("id > ?", id).first
    return next_item if next_item && next_item.gallery_id == gallery_id
  end

  def selfid
    gallery_id
  end
end
