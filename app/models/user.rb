class User < ActiveRecord::Base
  has_many :list_items
  has_many :foods, through: :list_items

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def generate_suggestions
    nutrient_progress
    foods = Food.where(preferred: true)
    @nutrient_compare_hash.each do |key, value|
      while @nutrient_compare_hash[key] > 0
        food = foods.order("#{key.to_s} DESC").limit(10)[rand(0..9)]
        unless self.foods.include?(food)
          self.foods << food
        end
        @nutrient_compare_hash[key] -= food.send(key)
      end
    end
  end

  def nutrient_progress
      @nutrient_compare_hash = {}
      @nutrient_goal_hash = {
         iron: 140,
         manganese: 35,
         phosphorus: 6825,
         selenium: 385,
         vitamin_a: 18662,
         vitamin_b6: 14,
         vitamin_b12: 18.9,
         vitamin_e: 105,
         vitamin_c: 560,
         vitamin_d: 4200,
         vitamin_k: 910,
         potassium: 32900,
         protein: 357,
         calcium: 7000,
         choline: 385,
         copper: 14,
         dietary_fiber: 210,
         fat_mono: 210,
         fat_poly: 210,
         folate: 2800,
         lutein: 42000,
         magnesium: 2555,
         zinc: 105,
         calories: 14000,
         carbs: 2275
     }

     update_nutrient_hash

     @nutrient_goal_hash.each do |key, value|
        @nutrient_compare_hash[key] = @nutrient_goal_hash[key] - @nutrient_hash[key]
      end
    end

    def update_nutrient_hash
    @nutrient_hash = {
        potassium: 0,
        protein: 0,
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
        zinc: 0,
        calories: 0,
        carbs: 0
    }


   self.foods.each do |f|
      @nutrient_hash.each do |key, value|
        unless f.nil?
          @nutrient_hash[key] += f.send(key)*3
        end
      end
    end
    return @nutrient_hash
  end

end
