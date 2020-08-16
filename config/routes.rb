Rails.application.routes.draw do
  root 'static_pages#home'

  resources :users, only: [:new, :create, :show]

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'recipes/index'
  get 'ratings/new'
  get 'categories/index'



  resources :users

  resources :categories do
    resources :recipes, only: [:index, :show]
  end

  resources :recipes

  resources :ratings, only: [:new, :create]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
