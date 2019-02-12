class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :user
      t.decimal :total_price
      t.boolean :checkout, default: false
      
      t.timestamps
    end
  end
end
