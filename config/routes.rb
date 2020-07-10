Rails.application.routes.draw do
  devise_for :users, controllers:{sessions: 'users/sessions',  registrations: 'users/registrations',}
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :items, only: [:index, :show, :new, :create] do
    member do
      get 'purchase'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_delivery_children', defaults: { format: 'json'}
    end
  end

  resources :categories, only: [:index]
end

