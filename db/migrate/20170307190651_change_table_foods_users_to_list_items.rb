class ChangeTableFoodsUsersToListItems < ActiveRecord::Migration[5.0]
  def change
    rename_table :foods_users, :list_items
  end
end
