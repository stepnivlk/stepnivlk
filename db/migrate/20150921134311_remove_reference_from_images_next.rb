class RemoveReferenceFromImagesNext < ActiveRecord::Migration
  def change
    remove_reference :images, :post
  end
end
