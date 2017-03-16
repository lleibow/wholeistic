class User < ActiveRecord::Base
  has_many :list_items
  has_many :foods, through: :list_items

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true


  def self.get_recommendations(user, prime_nutrient)

    dietary_needs = {preferred: true}
    user.attributes.each do |key, value|
      unless key == "new_user"
        if value == true
          dietary_needs[key] = value
        end
      end
    end

    @foods = Food.where(dietary_needs).order("#{prime_nutrient}").reverse
    @recommended_foods = @foods[0..15]

    return @recommended_foods
  end


  def generate_suggestions

    dietary_needs = {preferred: true}
    self.attributes.each do |key, value|
      if value == true
        dietary_needs[key] = value
      end
    end

    # protein =
    # unless self.date_of_birth == nil
    #   delta = (Date.today - self.date_of_birth) / 365
    #   case self.date_of_birth
    #     when delta.to_i < 50
    #        0.8 * self.weight_kg
    #      else
    #        (1 * self.weight_kg) * 7
    #     end
    # else
    #   357
    # end

    # calories =
    # unless self.activity_level == nil || self.weight_kg == nil
    #   case self.activity_level
    #     when "sedentary"
    #        (31 * self.weight_kg) * 7
    #      when "active"
    #        (36 * self.weight_kg) * 7
    #      when "athlete"
    #        (45 * self.weight_kg) * 7
    #     end
    #   else
    #     14000
    #   end

    # fat_mono =
    #   (15/100 * calories) * 7
    #
    # fat_poly =
    #     (15/100 * calories) * 7

    @nutrient_goal_hash = {
      iron: 6,
      manganese: 1.6,
      phosphorus: 600,
      selenium: 80,
      vitamin_a: 18000,
      vitamin_b6: 0.98,
      vitamin_b12: 18.9,
      vitamin_e: 3,
      vitamin_c: 200,
      vitamin_d: 100,
      vitamin_k: 235,
      potassium: 900,
      protein: 14,
      calcium: 240,
      choline: 70,
      copper: 2,
      dietary_fiber: 10,
      fat_mono: 12,
      fat_poly: 5.6,
      folate: 260,
      lutein: 10000,
      magnesium: 150,
      zinc: 5
    }

    def check_nutrients
      self.foods.each do |food|
        @nutrient_goal_hash.each do |key, value|
          if food.send(key) >= @nutrient_goal_hash[key]
            @nutrient_goal_hash.delete(key)
          end
        end
      end
    end

    @nutrient_goal_hash.each do |key, value|
      add_foods = Food.where(dietary_needs).order("#{key.to_s}").reverse
      add_food = add_foods[0..3][rand(0..3)]

      i = 0
      while (self.foods.include?(add_food) && i <= 3) || (add_food.send(key) < (@nutrient_goal_hash[key]/2) && i <= 3)
        add_foods = Food.where(dietary_needs).order("#{key.to_s}").reverse
        add_food = add_foods[0..3][rand(0..3)]
        i += 1
      end

      unless self.foods.include?(add_food) || add_food.send(key) < (@nutrient_goal_hash[key]/2)
        self.foods << add_food
        added_food = list_items.find_by("food_id = '#{add_food.id}'")
        added_food.recommended = true
        added_food.prime_nutrient = key.to_s
        added_food.save
      end
      check_nutrients
    end

  end



end
