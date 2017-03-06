class FoodsController < ApplicationController
    def new
        @food = Food.new
    end
    def create
        food_api_results = Food.food_api_results(food_search_params[:name])
        food_api_results['common'].each do |result|
            if Food.check_food_db(result)
              Food.food_in_db(current_user, result)
            else
              food_hash = Food.add_food_to_db(result)
            end
        end
        Food.add_food_to_list(current_user, food_search_params[:name])
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
