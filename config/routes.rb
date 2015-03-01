Rails.application.routes.draw do
  resources :mikanzs

  root to: 'top#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :mikanzs do
    resources :waterings
  end
end
