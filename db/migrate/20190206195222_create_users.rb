class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :uid
      t.boolean :seller, default: false
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
