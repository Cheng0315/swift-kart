Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  
  resources :users, only: [:new, :index, :create, :edit, :update] do 
    resources :items, only: [:index, :new, :create, :show]
  end

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do 
    resources :reviews, only: [:new, :create, :show]
  end

  resources :reviews, only: [:new, :create, :show]

  resources :carts, only: [:index]
  
  get '/cart' => 'carts#display_cart'
  get '/cart/delete_item' => 'carts#delete_item'
  post '/cart/checkout' => 'carts#checkout'
  get '/cart/user_cart' => 'carts#find_or_create_cart'
  get '/cart/add_guest_cart' => 'carts#add_guest_cart'

  post '/items/add_to_cart' => 'items#add_to_cart'
  get '/my_items' => 'items#my_items'
  get '/my_orders' => 'items#my_orders'
  get '/buyer_orders' => 'items#buyer_orders'
  get '/ship_items' => 'items#ship_items'

  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#logout'
  get '/auth/facebook/callback' => 'sessions#create'
end
