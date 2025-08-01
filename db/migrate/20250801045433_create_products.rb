class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.boolean :is_official
      t.references :convenience_store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
