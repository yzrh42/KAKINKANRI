Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  resources :users, only: [:new]

  root 'static_pages#top'

  get "up" => "rails/health#show", as: :rails_health_check
end
