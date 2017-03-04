class CreateFoodsUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :foods_users do |t|
      t.integer :food_id
      t.integer :list_id
      t.timestamps
    end
  end
end
