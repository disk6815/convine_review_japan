class CreateReviewRegions < ActiveRecord::Migration[7.2]
  def change
    create_table :review_regions do |t|
      t.references :review, null: false, foreign_key: true
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
