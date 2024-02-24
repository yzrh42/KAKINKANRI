Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  root 'static_pages#top'

  resources :users, only: [:new]
  resources :charges
  resources :games

  get "up" => "rails/health#show", as: :rails_health_check
end
