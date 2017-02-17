Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      get 'users/wishlist', to: 'users#wishlist'

      # Esta rota foi comentada pois ela exige um id para atualização do usuario
      # mais no caso de nosso user ele será o usuario corrente e sera identificado
      # atraves do token do devise
      # resources :users, only: [:update]

      get 'users', to: 'users#current_user'
      put 'users', to: 'users#update'

      get 'autocomplete', to: 'properties#autocomplete'
      get 'search', to: 'properties#search'

      resources :reservations do
        member do
          post 'evaluation', to: 'reservation#evaluation'
        end
      end

      get 'featured', to: 'properties#featured'
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
