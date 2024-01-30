Rails.application.routes.draw do
  devise_for :users

  resources :users

  root 'static_pages#top'

  get "up" => "rails/health#show", as: :rails_health_check
end
