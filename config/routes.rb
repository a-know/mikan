# == Route Map
#
#              Prefix Verb   URI Pattern                                 Controller#Action
#                root GET    /                                           top#index
#                     GET    /auth/:provider/callback(.:format)          sessions#create
#              logout GET    /logout(.:format)                           sessions#destroy
#         retire_user GET    /user/retire(.:format)                      users#retire
#                user DELETE /user(.:format)                             users#destroy
#        user_mikanzs GET    /users/:user_nickname/mikanzs(.:format)     mikanzs#users_mikanzs
#  user_notifications GET    /notifications(.:format)                    users#notifications
#  tag_search_mikanzs GET    /mikanzs/tag_search(.:format)               mikanzs#tag_search
#    mikanz_waterings POST   /mikanzs/:mikanz_id/waterings(.:format)     waterings#create
# new_mikanz_watering GET    /mikanzs/:mikanz_id/waterings/new(.:format) waterings#new
#     mikanz_watering DELETE /mikanzs/:mikanz_id/waterings/:id(.:format) waterings#destroy
#             mikanzs GET    /mikanzs(.:format)                          mikanzs#index
#                     POST   /mikanzs(.:format)                          mikanzs#create
#          new_mikanz GET    /mikanzs/new(.:format)                      mikanzs#new
#         edit_mikanz GET    /mikanzs/:id/edit(.:format)                 mikanzs#edit
#              mikanz GET    /mikanzs/:id(.:format)                      mikanzs#show
#                     PATCH  /mikanzs/:id(.:format)                      mikanzs#update
#                     PUT    /mikanzs/:id(.:format)                      mikanzs#update
#                     DELETE /mikanzs/:id(.:format)                      mikanzs#destroy
#

Rails.application.routes.draw do
  root to: 'top#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resource :user, only: :destroy do
    get 'retire'
  end

  resources :users, param: :nickname, only: [] do
    scope controller: :mikanzs do
      get :mikanzs, action: :users_mikanzs
    end
  end

  get 'notifications' => 'users#notifications', as: :user_notifications

  resources :mikanzs do
    collection do
      get 'tag_search'
    end
    resources :waterings, only: [:new, :create, :destroy]
  end
end
