Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:index, :create, :show, :edit, :update] do 
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  get '/items/:id/add_to_cart' => 'items#add_to_cart'
  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#logout'
end
