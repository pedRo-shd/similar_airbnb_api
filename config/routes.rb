Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      get 'users/wishlist', to: 'users#wishlist'
      resources :users, only: [:update]

      get 'search', to: 'properties#search'

      resources :properties do
        #O member automaticamente coloca o :id porque é o membro da propriedade
        #Esse member é usado quando é preciso fazer alteração na classe neste
        #caso preciso do id da properties pra fazer alteração.
        member do
          post 'wishlist', to: 'properties#add_to_wishlist'
          delete 'wishlist', to: 'properties#remove_from_wishlist'
        end
      end
    end
  end
end
