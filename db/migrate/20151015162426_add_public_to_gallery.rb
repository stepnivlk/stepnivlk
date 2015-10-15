class AddPublicToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :public, :boolean
  end
end
