Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: [:index, :show, :new, :create] do
    member do
      get 'purchase'
    end
  end

end

