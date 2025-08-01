class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string :convenience_store_name
      t.string :product_name
      t.float :rating
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
