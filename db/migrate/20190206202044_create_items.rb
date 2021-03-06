class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.integer :condition
      t.boolean :in_stock
      t.boolean :shipped
      t.belongs_to :user
      t.belongs_to :category

      t.timestamps
    end
  end
end
