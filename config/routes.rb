Rails.application.routes.draw do
  root "homepage#index"

  resources :homepage, only: [:index]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
