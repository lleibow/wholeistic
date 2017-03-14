class AddNewUserToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :new_user, :boolean
  end
end
