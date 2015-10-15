class AddExitToImage < ActiveRecord::Migration
  def change
    add_column :images, :exif_date, :datetime
  end
end
