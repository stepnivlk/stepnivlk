class CreateSimpleUserInfos < ActiveRecord::Migration
  def change
    create_table :simple_user_infos do |t|
      t.string :info
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
