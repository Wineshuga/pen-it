Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
        resources :likes, only: [:new, :create, :destroy]
    end
  end

  namespace :api do
    resources :users, only: [:show] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
