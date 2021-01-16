Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'user_works#index'
  end

  root to: 'about#index', as: :unauthenticated_root
  
  resources :users, only: :show do
    resources :creators, controller: :user_creators, only: [:index, :new, :create]
    resources :works, controller: :user_works, only: [:index, :new, :create]
  end
  resources :creators, only: [:show, :edit, :update, :destroy] do
    resources :families, only: [:new, :create, :destroy]
  end
  resources :works, only: [:show, :edit, :update, :destroy]
end
