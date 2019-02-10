Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:index, :create, :show, :edit, :update] do 
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :carts, only: [:index]
  
  get '/cart' => 'carts#display_cart'
  get '/cart/delete_item' => 'carts#delete_item'
  post '/cart/checkout' => 'carts#checkout'
  get '/cart/user_cart' => 'carts#find_or_create_cart'
  get '/cart/add_guest_cart' => 'carts#add_guest_cart'

  get '/items/:id/add_to_cart' => 'items#add_to_cart'
  get '/my_items' => 'items#my_items'

  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#logout'
end
