Rails.application.routes.draw do
  get 'recipe_ingredients/new'
  get 'ingredients/new'
  root 'static_pages#home'

  resources :users

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/github/callback' => 'sessions#create'

  get 'recipes/index'
  get 'ratings/new'
  get 'categories/index'



  resources :users

  resources :categories do
    resources :recipes, only: [:index, :show]
  end

  resources :categories
  resources :recipe_ingredients

  resources :recipes do
    resources :categories, only: [:new, :create, :index]
    resources :recipe_ingredients, only: [:new, :create]
  end

  resources :ratings, only: [:new, :create]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
