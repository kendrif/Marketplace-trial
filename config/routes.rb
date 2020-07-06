require 'sidekiq/web'

Rails.application.routes.draw do
  get 'users/show'
  get 'admin/index'

  get "a/:id" => "store#profile", as: :profile

  resources :store

  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'
  resources :products
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :projects do
    resources :comments, module: :projects
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resource :subscription

  root to: 'projects#index'
end