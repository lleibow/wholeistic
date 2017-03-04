class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :height_cm, :integer
    add_column :users, :weight_kg, :integer
    add_column :users, :vegan, :boolean
    add_column :users, :veg, :boolean
    add_column :users, :dairy_free, :boolean
    add_column :users, :nut_free, :boolean
    add_column :users, :pescatarian, :boolean
    add_column :users, :gluten_free, :boolean
  end
end
