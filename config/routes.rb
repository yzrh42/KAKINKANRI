Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  post '/callback' => 'linebot#callback'

  root 'static_pages#top'

  get 'contact', to: 'static_pages#contact'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'

  resources :users, only: [:new]
  resources :homes, only: [:index]
  resources :charges
  resources :games
  resources :budgets
  resources :gachas
  resources :stones

  get "up" => "rails/health#show", as: :rails_health_check
end
