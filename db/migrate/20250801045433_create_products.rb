class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.boolean :is_official

      t.timestamps
    end
  end
end
