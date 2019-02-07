Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:index, :new, :create, :show, :edit, :update] do 
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#logout'
end
