class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.datetime :start
      t.datetime :end
      t.string :name
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
