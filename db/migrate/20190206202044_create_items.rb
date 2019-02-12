class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.boolean :in_stock
      t.belongs_to :user
      t.belongs_to :category

      t.timestamps
    end
  end
end
