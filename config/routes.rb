Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'}
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :users, only: [:show, :logout, :destroy, :new] do
    collection do
      get 'logout'
      get 'cardindex'
      get 'cardnew'
      post 'cardcreate'
      get 'bookmarks'
      get 'sellitem'
      get 'sellitem_trade'
      get 'sellitem_sold'
    end
  end
  resources :items do
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
    get 'get_delivery_children', defaults: { format: 'json'}
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_delivery_children', defaults: { format: 'json'}
      get 'search'
      resources :bookmarks, only:[:create, :destroy]
    end
    member do
      get 'purchase'
      get 'purchase_done'
      post 'pay', to:'items#pay'
    end
  end
  resources :categories, only: [:index]

end

