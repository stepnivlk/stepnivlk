class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.attachment :file
      t.text :file_meta
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
