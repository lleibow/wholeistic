class User < ActiveRecord::Base
  has_many :list_items
  has_many :foods, through: :list_items

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true


  def self.diet_settings(user)
    dietary_needs = {preferred: true}
      user.attributes.each do |key, value|
        unless key == "new_user"
          if value == true
            dietary_needs[key] = value
          end
        end
      end
    return dietary_needs
  end

  def self.get_recommendations(user, prime_nutrient)

    dietary_needs = User.diet_settings(user)

    @foods = Food.where(dietary_needs).order("#{prime_nutrient}").reverse
    @recommended_foods = @foods[0..15]

    return @recommended_foods
  end

  def generate_suggestions

    dietary_needs = User.diet_settings(self)

    @nutrient_goal_hash = {
      iron: 6,
      manganese: 1.6,
      phosphorus: 600,
      selenium: 80,
      vitamin_a: 22000,
      vitamin_b6: 0.98,
      vitamin_b12: 18.9,
      vitamin_e: 3,
      vitamin_c: 200,
      vitamin_d: 100,
      vitamin_k: 235,
      potassium: 900,
      protein: 20,
      calcium: 240,
      choline: 70,
      copper: 2,
      dietary_fiber: 15,
      monounsaturated_fat: 12,
      polyunsaturated_fat: 5.6,
      folate: 260,
      lutein: 10000,
      magnesium: 150,
      zinc: 5
    }

    self.foods.each do |food|
      @nutrient_goal_hash.each do |key, value|
        if food.send(key) >= @nutrient_goal_hash[key]
          @nutrient_goal_hash.delete(key)
        end
      end
    end

    @nutrient_goal_hash.each do |key, value|

      case
      when self.vegan == true && key == 'vitamin_b12'
        bran = Food.find_by(name: "bran flakes")
        self.foods << bran unless self.foods.include?(bran)
      when self.vegan == true && key == 'vitamin_d'
        soy = Food.find_by(name: "soy milk")
        self.foods << soy unless self.foods.include?(soy)
      when self.vegan == true && key == 'copper'
        sunflower = Food.find_by(name: "sunflower seeds")
        self.foods << sunflower unless self.foods.include?(sunflower)
      else
        add_foods = Food.where(dietary_needs).order("#{key.to_s}").reverse
        add_food = add_foods[0..3][rand(0..3)]
      end

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

    end

  end

end
