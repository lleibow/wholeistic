class Food < ApplicationRecord

  has_and_belongs_to_many :users

  include HTTParty

 def self.food_search(query)
    @url = 'https://www.nutritionix.com/track-api/v2/search/instant?branded=false&common=true&self=false&query='
    response = HTTParty.get(@url + query)
  end

 def self.nutrient_lookup(query)
    @url =
    'https://trackapi.nutritionix.com/v2/natural/nutrients'
    HTTParty.post(@url,
            :headers=>{'x-app-key': Rails.application.secrets.nutritionix_app_key, 
                       'x-app-id': Rails.application.secrets.nutritionix_app_id},
            :body=>{"query": query}
            )
  end

end
