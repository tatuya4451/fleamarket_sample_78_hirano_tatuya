Rails.application.routes.draw do
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

end

