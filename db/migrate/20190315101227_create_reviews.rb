class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.belongs_to :user
      t.belongs_to :item

      t.timestamps
    end
  end
end
