class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :real_name, :string
    add_column :users, :birth_date, :datetime
    add_column :users, :phone, :string
  end
end
