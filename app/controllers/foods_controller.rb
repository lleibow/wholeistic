class FoodsController < ApplicationController
    def new
        @food = Food.new
    end

    def create
      @user = current_user
      food_api_results = Food.food_api_results(food_search_params[:name])

      if food_api_results.empty?
        redirect_to root_path

      elsif
        result = food_api_results['common'][0]
        Food.add_food_to_db(result)
        Food.add_food_to_list(current_user, Food.where(name: result['food_name']))
        redirect_to root_path

      elsif food_api_results["common"] == []
        Food.add_custom_item(@user, food_search_params[:name])
        redirect_to root_path
      end
    end

    def show
        @food = Food.find(params[:id])
    end

    def index
      @foods = Food.all
      render layout: false

    end

    def update
      @food = Food.find(params[:id])
      @food.vegan = params[:food][:vegan]
      @food.veg = params[:food][:veg]
      @food.gluten_free = params[:food][:gluten_free]
      @food.dairy_free = params[:food][:dairy_free]
      @food.nut_free = params[:food][:nut_free]
      @food.pescatarian = params[:food][:pescatarian]

      if @food.preferred == false
        @food.preferred = true
      else
        @food.preferred = false
      end

      @food.save
      redirect_to foods_path
    end

    def destroy
        @food = Food.destroy
        redirect_to :back
    end

    private

    def food_search_params
        params.require(:food).permit(:id, :name, :preferred, :vegan, :veg, :dairy_free, :gluten_free, :nut_free, :pescatarian)
    end
end
