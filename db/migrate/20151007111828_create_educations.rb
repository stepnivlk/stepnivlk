class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.date :start
      t.date :end
      t.string :name
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
