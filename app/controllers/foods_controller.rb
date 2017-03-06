class FoodsController < ApplicationController
    def new
        @food = Food.new
    end
    def create
        food_api_results = Food.food_api_results(food_search_params[:name])
        result = food_api_results['common'][0]
        Food.add_food_to_db(result)
        Food.add_food_to_list(current_user, Food.where(name: result['food_name']))
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
