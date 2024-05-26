Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  post '/callback', to: 'linebot#callback'

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
  resources :bans

  get 'gachas/:game_id/gacha_ban_period', to: 'gachas#gacha_ban_period', as: 'gacha_ban_period'

  resources :wishlists do
    member do
      get :move_higher
      get :move_lower
      put :purchase
    end
    collection do
      get 'purchased_wishlists', to: 'wishlists#purchased', as: 'purchased_wishlists'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
