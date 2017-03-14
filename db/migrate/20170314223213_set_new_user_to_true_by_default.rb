class SetNewUserToTrueByDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :new_user, true
  end
end
