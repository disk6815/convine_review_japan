class CreateReviewTastes < ActiveRecord::Migration[7.2]
  def change
    create_table :review_tastes do |t|
      t.references :review, null: false, foreign_key: true
      t.references :taste, null: false, foreign_key: true

      t.timestamps
    end
  end
end
