Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#show'
  resources :user_sessions
  resources :foods
  resources :users do
    get 'update_foods', to: 'users#update_list'
    get 'remove_item', to: 'users#remove_item'
    get 'clear_list', to: 'users#clear_list'

  end
  get 'clear_list', to: 'users#clear_list'

 get 'login' => 'user_sessions#new', :as => :login
 post 'logout' => 'user_sessions#destroy', :as => :logout

end