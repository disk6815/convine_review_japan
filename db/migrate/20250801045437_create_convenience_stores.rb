class CreateConvenienceStores < ActiveRecord::Migration[7.2]
  def change
    create_table :convenience_stores do |t|
      t.string :name

      t.timestamps
    end
  end
end
