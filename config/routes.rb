Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#show'
  resources :user_sessions
  resources :foods
  resources :users do
    get 'update_foods', to: 'users#update_list'
    get 'remove_item', to: 'users#remove_item'
    get 'clear_list', to: 'users#clear_list'
    get 'clear_pantry', to: 'users#clear_pantry'
    get 'pantry', to: 'users#pantry'
    get 'pantry_show', to: 'users#pantry_show'
    get 'add_back', to: 'users#add_back'
  end
  get 'clear_list', to: 'users#clear_list'


  get '/settings', to: 'users#edit', as: :settings
  get '/signup', to: 'users#new', as: :register
  get '/login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
