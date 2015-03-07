Rails.application.routes.draw do
  resources :mikanzs

  root to: 'top#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resource :user, only: :destroy do
    get 'retire'
  end

  resources :mikanzs do
    resources :waterings
  end
end
