class AddDefaultValuesToFoodTable < ActiveRecord::Migration[5.0]
  def change
    change_column :foods, :serving_qty, :float, default: 0
    change_column :foods, :serving_unit, :float, default: 0
    change_column :foods, :serving_weight_grams, :float, default: 0
    change_column :foods, :calcium, :float, default: 0
    change_column :foods, :calories, :float, default: 0
    change_column :foods, :carbs, :float, default: 0
    change_column :foods, :copper, :float, default: 0
    change_column :foods, :choline, :float, default: 0
    change_column :foods, :dietary_fiber, :float, default: 0
    change_column :foods, :fat_mono, :float, default: 0
    change_column :foods, :fat_poly, :float, default: 0
    change_column :foods, :folate, :float, default: 0
    change_column :foods, :iron, :float, default: 0
    change_column :foods, :lutein, :float, default: 0
    change_column :foods, :manganese, :float, default: 0
    change_column :foods, :magnesium, :float, default: 0
    change_column :foods, :phosphorus, :float, default: 0
    change_column :foods, :potassium, :float, default: 0
    change_column :foods, :protein, :float, default: 0
    change_column :foods, :selenium, :float, default: 0
    change_column :foods, :sodium, :float, default: 0
    change_column :foods, :sugars, :float, default: 0
    change_column :foods, :vitamin_a, :float, default: 0
    change_column :foods, :vitamin_b6, :float, default: 0
    change_column :foods, :vitamin_b12, :float, default: 0
    change_column :foods, :vitamin_c, :float, default: 0
    change_column :foods, :vitamin_d, :float, default: 0
    change_column :foods, :vitamin_e, :float, default: 0
    change_column :foods, :vitamin_k, :float, default: 0
    change_column :foods, :zinc, :float, default: 0

  end
end
