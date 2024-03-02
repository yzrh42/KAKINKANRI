Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  root 'static_pages#top'

  resources :users, only: [:new]
  resources :homes, only: [:index]
  resources :charges
  resources :games
  resources :budgets

  get "up" => "rails/health#show", as: :rails_health_check
end
