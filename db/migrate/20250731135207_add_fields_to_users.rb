class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :nationality, :integer
    add_column :users, :language, :integer
  end
end
