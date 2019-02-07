class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :price
      t.string :description
      t.belongs_to :category
      t.belongs_to :user

      t.timestamps
    end
  end
end
