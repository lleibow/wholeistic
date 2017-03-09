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
    dietary_needs = {preferred: true}
    self.attributes.each do |key, value|
      if value == true
        dietary_needs[key] = value
      end
    end

    @nutrient_compare_hash.each do |key, value|
      while @nutrient_compare_hash[key] > 0
        food = Food.where(dietary_needs).order("#{key.to_s} DESC").limit(10)[rand(0..9)]
        unless self.foods.include?(food)
            self.foods << food
        end
        @nutrient_compare_hash[key] -= food.send(key)
      end
    end
  end

  def nutrient_progress
      @nutrient_compare_hash = {}
      delta = (Date.today - self.date_of_birth) / 365
      protein =
      unless self.date_of_birth == nil
        case self.date_of_birth
          when delta.to_i < 50
             0.8 * self.weight_kg
           else
             (1 * self.weight_kg) * 7
          end
        else
          357
        end

        calories =
        unless self.activity_level == nil && self.weight_kg == nil
          case self.activity_level
            when "sedentary"
               (31 * self.weight_kg) * 7
             when "active"
               (36 * self.weight_kg) * 7
             when "athlete"
               (45 * self.weight_kg) * 7
            end
          else
            14000
          end

        fat_mono =
          (15/100 * calories) * 7

        fat_poly =
            (15/100 * calories) * 7

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
         protein: protein,
         calcium: 7000,
         choline: 385,
         copper: 14,
         dietary_fiber: 210,
         fat_mono: fat_mono,
         fat_poly: fat_poly,
         folate: 2800,
         lutein: 42000,
         magnesium: 2555,
         zinc: 105,
         calories: calories,
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
