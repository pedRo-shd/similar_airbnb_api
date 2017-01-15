Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :properties
    end
  end
  namespace :api do
    namespace :v1 do
    end
  end
end
