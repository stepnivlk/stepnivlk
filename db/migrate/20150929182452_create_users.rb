class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true, unique: true
      t.string :password_digest
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
