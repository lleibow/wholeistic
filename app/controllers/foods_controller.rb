class FoodsController < ApplicationController
    def new
        @food = Food.new
    end

    def create

        @food = Food.new
        @user = current_user
        food_api_results = Food.food_api_results(food_search_params[:name])

        if food_api_results.empty?
          redirect_to root_path

        elsif food_api_results["common"] == []
          @item = Food.add_custom_item(@user, food_search_params[:name])
          if params[:add_to_pantry]
            Food.add_to_pantry(@item)
            redirect_to user_pantry_show_path(current_user)
          else
            redirect_to root_path
          end

      elsif
        result = food_api_results['common'][0]
        Food.add_food_to_db(result)
        @new_food = Food.find_by(name: result['food_name'].gsub('-', ' '))
        Food.add_food_to_list(@user, @new_food)
        @item = @user.list_items.find_by(food_id: @new_food.id)
        if params[:add_to_pantry]
          Food.add_to_pantry(@item)
          redirect_to user_pantry_show_path(current_user)
        else
          redirect_to root_path
        end
      end
    end

    def show

        @food = Food.find(params[:id])
    end

    def index

      @admins = ["me@alexf.ca", "joshkestenberg@gmail.com", "jurgenehahn@gmail.com", "lauraleibow@gmail.com"]

      if @admins.include?(current_user.email)
        @foods = Food.all
        render layout: false
      else
        redirect_to root_path
      end

    end

    def update
      @food = Food.find(params[:id])
      @food.name = params[:name]
      @food.vegan = params[:vegan]
      @food.veg = params[:veg]
      @food.gluten_free = params[:gluten_free]
      @food.dairy_free = params[:dairy_free]
      @food.nut_free = params[:nut_free]
      @food.pescatarian = params[:pescatarian]
      @food.preferred = params[:preferred]

      @food.save
    end

    def destroy
        @food = Food.find(params[:id])
        @food.destroy
    end

    private

    def food_search_params
        params.require(:food).permit(:id, :name, :preferred, :vegan, :veg, :dairy_free, :gluten_free, :nut_free, :pescatarian)
    end
end
