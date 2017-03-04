class ChangeListIdToUserId < ActiveRecord::Migration[5.0]
  def change
    rename_column :foods_users, :list_id, :user_id
  end
end
