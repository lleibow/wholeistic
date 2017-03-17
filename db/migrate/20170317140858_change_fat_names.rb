class ChangeFatNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :foods, :fat_mono, :monounsaturated_fat
    rename_column :foods, :fat_poly, :polyunsaturated_fat
    rename_column :foods, :carbs, :carbohydrates
  end
end
