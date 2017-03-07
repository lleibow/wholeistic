class AddColumnPantryToJoinTable < ActiveRecord::Migration[5.0]
  def change
    add_column :foods_users, :pantry, :boolean, default: false
  end
end
