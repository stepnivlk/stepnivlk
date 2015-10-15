class AddExifToImage < ActiveRecord::Migration
  def change
    add_column :images, :exif_exposure_time, :string
    add_column :images, :exif_f_number, :float
  end
end
