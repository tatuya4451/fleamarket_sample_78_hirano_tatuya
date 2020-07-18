Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_for :users, controllers:{sessions: 'users/sessions',  registrations: 'users/registrations',}
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
      get 'bookmarks'
    end
  end
  resources :items do
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
    get 'get_delivery_children', defaults: { format: 'json'}
    collection do
      get 'purchase'
      get 'purchase_done'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_delivery_children', defaults: { format: 'json'}
      get 'search'
      resources :bookmarks, only:[:create, :destroy]
    end
  end
  resources :categories, only: [:index]
  post 'pay', to:'cards#pay'

end

