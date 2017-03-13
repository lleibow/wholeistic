class DropJoinTableFoodsUsers < ActiveRecord::Migration[5.0]
  def change
    drop_join_table :foods, :users
  end
end
