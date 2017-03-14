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
      if value == true
        dietary_needs[key] = value
      end
    end
    puts "================================================"

    puts prime_nutrient
    puts "================================================"
    @search = "#{prime_nutrient} DESC"
    puts "================================================"

    puts @search
    puts "================================================"


    @foods = Food.where(dietary_needs).order("#{prime_nutrient}").reverse
    @recommended_foods = @foods[0..15]

    return @recommended_foods
  end


  def generate_suggestions
    nutrient_progress
    dietary_needs = {preferred: true}
    self.attributes.each do |key, value|
      if value == true
        dietary_needs[key] = value
      end
    end

    nutrient_lack

    while @nutrient_lack_total > 0
      @nutrient_compare_hash.each do |key, value|
        if @nutrient_compare_hash[key] > 0
          foods = Food.where(dietary_needs).order("#{key.to_s}").reverse
          food = foods[0..4][rand(0..4)]
          
          unless self.foods.include?(food)
            self.foods << food
            added_food = list_items.find_by("food_id = '#{food.id}'")
            added_food.update_attribute(:recommended, true)
            added_food.update_attribute(:prime_nutrient, "#{key.to_s}")
          end
          @nutrient_compare_hash[key] -= food.send(key)
        end
      end
      nutrient_lack
    end
  end

  def nutrient_progress
      @nutrient_compare_hash = {}
      protein =
      unless self.date_of_birth == nil
        delta = (Date.today - self.date_of_birth) / 365
        case self.date_of_birth
          when delta.to_i < 50
             0.8 * self.weight_kg
           else
             (1 * self.weight_kg) * 7
          end
        else
          357
        end

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
        #  fat_mono: fat_mono,
        #  fat_poly: fat_poly,
         folate: 2800,
         lutein: 42000,
         magnesium: 2555,
         zinc: 105,
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
        # fat_mono: 0,
        # fat_poly: 0,
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
    }


   self.foods.each do |f|
      @nutrient_hash.each do |key, value|
        unless f.nil?
          @nutrient_hash[key] += f.send(key) * 3
        end
      end
    end
    return @nutrient_hash
  end

  def nutrient_lack
    @nutrient_lack_total = 0

    @nutrient_compare_hash.each do |key, value|
      if value >= 0
        @nutrient_lack_total += value
      end
    end

    return @nutrient_lack_total
  end

end
