Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items, only: [:index, :show, :new] do
    member do
      get 'purchase'
    end
  end
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
end
