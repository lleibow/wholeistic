class FoodsController < ApplicationController
    def new
        @food = Food.new
    end
    def create
        food_api_results = Food.food_search(food_search_params[:name])
          # Remove this [0..1] !!!!
        food_api_results['common'].each do |result|
          # Remove this [0..1] !!!!
            if Food.where(name: result['food_name']).present?
                @food = Food.where(name: result['food_name'])
                current_user.foods << @food
                return

            else
                food_name = result['food_name'].to_s.strip
                food_nutrients = Food.nutrient_lookup(food_name)
                food_hash =
                    {
                        name: food_nutrients['foods'][0]['food_name'].strip,
                        serving_qty: food_nutrients['foods'][0]['serving_qty'],
                        serving_unit: food_nutrients['foods'][0]['serving_unit'],
                        serving_weight_grams: food_nutrients['foods'][0]['serving_weight_grams'],
                        calories: food_nutrients['foods'][0]['nf_calories'],
                        carbs: food_nutrients['foods'][0]['nf_total_carbohydrate'],
                        potassium: food_nutrients['foods'][0]['nf_potassium'],
                        protein: food_nutrients['foods'][0]['nf_protein'],
                        sodium: food_nutrients['foods'][0]['nf_sodium'],
                        sugars: food_nutrients['foods'][0]['nf_sugars'],
                        calcium: 0,
                        choline: 0,
                        copper: 0,
                        dietary_fiber: 0,
                        iron: 0,
                        fat_mono: 0,
                        fat_poly: 0,
                        folate: 0,
                        lutein: 0,
                        magnesium: 0,
                        manganese: 0,
                        phosphorus: 0,
                        selenium: 0,
                        vitamin_a: 0,
                        vitamin_b6: 0,
                        vitamin_b12: 0,
                        vitamin_e: 0,
                        vitamin_c: 0,
                        vitamin_d: 0,
                        vitamin_k: 0,
                        vegan: false,
                        veg: false,
                        preferred: false,
                        zinc: 0
                    }
                food_nutrients['foods'][0]['full_nutrients'].each do |nutrient|
                    if nutrient['attr_id'] == 301
                        food_hash[:calcium] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 421
                        food_hash[:choline] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 312
                        food_hash[:copper] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 291
                        food_hash[:dietary_fiber] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 303
                        food_hash[:iron] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 645
                        food_hash[:fat_mono] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 646
                        food_hash[:fat_poly] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 432
                        food_hash[:folate] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 338
                        food_hash[:lutein] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 304
                        food_hash[:magnesium] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 315
                        food_hash[:manganese] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 305
                        food_hash[:phosphorus] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 317
                        food_hash[:selenium] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 318
                        food_hash[:vitamin_a] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 415
                        food_hash[:vitamin_b6] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 418
                        food_hash[:vitamin_b12] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 323
                        food_hash[:vitamin_e] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 401
                        food_hash[:vitamin_c] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 324
                        food_hash[:vitamin_d] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 430
                        food_hash[:vitamin_k] = nutrient['value']
                    end
                    if nutrient['attr_id'] == 309
                        food_hash[:zinc] = nutrient['value']
                    end
                end
                @food = Food.create(food_hash)
                current_user.foods << @food

            end
          end
        redirect_to root_path
      end
    def show
        @food = Food.find(params[:id])
    end
    def index
        @foods = Food.all
    end

    def update
      @food = Food.find(params[:id])
      if @food.preferred == false
        @food.preferred = true
      else
        @food.preferred = false
      end
      @food.save
    end

    def destroy
        @food = Food.destroy
    end

    private

    def food_search_params
        params.require(:food).permit(:id, :name, :preferred)
    end
end
