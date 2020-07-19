Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :users, only: [:show, :logout,:destroy] do
    collection do
      get 'logout'
      get 'cardindex'
      get 'cardnew'
      post 'cardcreate'
      
    end
  end
  resources :items, only: [:index, :show, :new, :create] do
    collection do
      get 'purchase'
      get 'purchase_done'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_delivery_children', defaults: { format: 'json'}
      get 'search'
    end
  end
  resources :categories, only: [:index]

  post 'pay', to:'cards#pay'

end

