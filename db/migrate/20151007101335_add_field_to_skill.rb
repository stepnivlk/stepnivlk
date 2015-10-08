class AddFieldToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :skill_index, :integer
    add_index :skills, :skill_index
    add_index :skills, :in_love_index
  end
end
