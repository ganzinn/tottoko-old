Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'works#index'
  resources :creators do
    resources :families, only: [:new, :create]
  end

end
