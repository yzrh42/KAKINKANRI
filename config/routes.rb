Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  root 'static_pages#top'

  get 'contact', to: 'static_pages#contact'

  resources :users, only: [:new]
  resources :homes, only: [:index]
  resources :charges
  resources :games
  resources :budgets
  resources :gachas
  resources :stones

  get "up" => "rails/health#show", as: :rails_health_check
end
