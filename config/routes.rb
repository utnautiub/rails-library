Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'admin/login', to: 'admins#login'
      post 'user/login', to: 'users#login'
      resources :books
      resources :authors
      resources :genres
      resources :users
      resources :borrowings
      resources :borrowing_items
      resources :ratings
      resources :admins
    end
  end
end
