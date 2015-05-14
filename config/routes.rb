# == Route Map
#
#               Prefix Verb   URI Pattern                                      Controller#Action
#              mikanzs GET    /mikanzs(.:format)                               mikanzs#index
#                      POST   /mikanzs(.:format)                               mikanzs#create
#           new_mikanz GET    /mikanzs/new(.:format)                           mikanzs#new
#          edit_mikanz GET    /mikanzs/:id/edit(.:format)                      mikanzs#edit
#               mikanz GET    /mikanzs/:id(.:format)                           mikanzs#show
#                      PATCH  /mikanzs/:id(.:format)                           mikanzs#update
#                      PUT    /mikanzs/:id(.:format)                           mikanzs#update
#                      DELETE /mikanzs/:id(.:format)                           mikanzs#destroy
#                 root GET    /                                                top#index
#                      GET    /auth/:provider/callback(.:format)               sessions#create
#               logout GET    /logout(.:format)                                sessions#destroy
#          retire_user GET    /user/retire(.:format)                           users#retire
#                 user DELETE /user(.:format)                                  users#destroy
#   tag_search_mikanzs GET    /mikanzs/tag_search(.:format)                    mikanzs#tag_search
#     mikanz_waterings GET    /mikanzs/:mikanz_id/waterings(.:format)          waterings#index
#                      POST   /mikanzs/:mikanz_id/waterings(.:format)          waterings#create
#  new_mikanz_watering GET    /mikanzs/:mikanz_id/waterings/new(.:format)      waterings#new
# edit_mikanz_watering GET    /mikanzs/:mikanz_id/waterings/:id/edit(.:format) waterings#edit
#      mikanz_watering GET    /mikanzs/:mikanz_id/waterings/:id(.:format)      waterings#show
#                      PATCH  /mikanzs/:mikanz_id/waterings/:id(.:format)      waterings#update
#                      PUT    /mikanzs/:mikanz_id/waterings/:id(.:format)      waterings#update
#                      DELETE /mikanzs/:mikanz_id/waterings/:id(.:format)      waterings#destroy
#                      GET    /mikanzs(.:format)                               mikanzs#index
#                      POST   /mikanzs(.:format)                               mikanzs#create
#                      GET    /mikanzs/new(.:format)                           mikanzs#new
#                      GET    /mikanzs/:id/edit(.:format)                      mikanzs#edit
#                      GET    /mikanzs/:id(.:format)                           mikanzs#show
#                      PATCH  /mikanzs/:id(.:format)                           mikanzs#update
#                      PUT    /mikanzs/:id(.:format)                           mikanzs#update
#                      DELETE /mikanzs/:id(.:format)                           mikanzs#destroy
#

Rails.application.routes.draw do
  resources :mikanzs

  root to: 'top#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resource :user, only: :destroy do
    get 'retire'
  end

  resources :mikanzs do
    collection do
      get 'tag_search'
    end
    resources :waterings
  end
end
