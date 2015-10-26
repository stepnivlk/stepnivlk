class Image < ActiveRecord::Base
  include Tags

  belongs_to :gallery


  has_attached_file :file, styles: { original: "1200x1200>", medium: "800x800>", thumb: "260x200#" }
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  after_post_process :add_exif

  # Returns previous image , if exists and belongs to same gallery.
  def prev
    prev_item = Image.where("id < ?", id).last
    return prev_item if prev_item && prev_item.gallery_id == gallery_id
  end

  # Returns next image , if exists and belongs to same gallery.
  def next
    next_item = Image.where("id > ?", id).first
    return next_item if next_item && next_item.gallery_id == gallery_id
  end

  def selfid
    gallery_id
  end

  def identity
    "image"
  end

  # Adds EXIF informations to image.
  def add_exif
    exif = EXIFR::JPEG.new(file.queued_for_write[:original].path)
    return unless exif
    self.exif_date = exif.date_time.to_date if exif.date_time
    self.exif_exposure_time = exif.exposure_time.to_s if exif.exposure_time
    self.exif_f_number = exif.f_number.to_f if exif.f_number
  end
end
