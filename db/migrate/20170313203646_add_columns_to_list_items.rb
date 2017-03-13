class AddColumnsToListItems < ActiveRecord::Migration[5.0]
  def change
    add_column :list_items, :recommended, :boolean, default: false
    add_column :list_items, :prime_nutrient, :string
  end
end
