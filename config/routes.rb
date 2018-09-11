Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/oauth/callback', to: 'o_auth#callback'

  resources :photos, only: [:index, :new, :create]
end
