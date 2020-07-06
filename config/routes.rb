Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: [:index, :show, :new] do
    member do
      get 'purchase'
    end
  end

end
