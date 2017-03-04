class AddColumnsToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :preferred, :boolean, default: false
    add_column :foods, :dairy_free, :boolean, default: false
    add_column :foods, :gluten_free, :boolean, default: false
    add_column :foods, :nut_free, :boolean, default: false
    add_column :foods, :pescatarian, :boolean, default: false
    add_column :foods, :veg, :boolean, default: false
    add_column :foods, :vegan, :boolean, default: false
    add_column :foods, :name, :string
    add_column :foods, :serving_qty, :float
    add_column :foods, :serving_unit, :float
    add_column :foods, :serving_weight_grams, :float
    add_column :foods, :calcium, :float
    add_column :foods, :calories, :float
    add_column :foods, :carbs, :float
    add_column :foods, :copper, :float
    add_column :foods, :choline, :float
    add_column :foods, :dietary_fiber, :float
    add_column :foods, :fat_mono, :float
    add_column :foods, :fat_poly, :float
    add_column :foods, :folate, :float
    add_column :foods, :iron, :float
    add_column :foods, :lutein, :float
    add_column :foods, :manganese, :float
    add_column :foods, :magnesium, :float
    add_column :foods, :phosphorus, :float
    add_column :foods, :potassium, :float
    add_column :foods, :protein, :float
    add_column :foods, :selenium, :float
    add_column :foods, :sodium, :float
    add_column :foods, :sugars, :float
    add_column :foods, :vitamin_a, :float
    add_column :foods, :vitamin_b6, :float
    add_column :foods, :vitamin_b12, :float
    add_column :foods, :vitamin_c, :float
    add_column :foods, :vitamin_d, :float
    add_column :foods, :vitamin_e, :float
    add_column :foods, :vitamin_k, :float
    add_column :foods, :zinc, :float
  end
end
