Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'works#index'
  resources :creators, only: [:new, :create]

end
