Rails.application.routes.draw do

  root "sessions#index"

  get '/login'    => 'sessions#new'
  post '/login'   => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/signup'   => 'users#new'
  post '/signup'  => 'users#create'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/auth/:provider/callback', to: 'sessions#google'
  #http://localhost:3000/auth/github/callback

  resources :users, except: [:new, :index] do 
    resources :players # i dont really need it
  end 
  resources :reviews
  
  resources :teams do 
    resources :players, only: [:index, :show]
  end 
  resources :players do 
    resources :reviews, only: [:new, :index]
  end 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 