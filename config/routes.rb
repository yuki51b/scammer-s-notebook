# frozen_string_literal: true

Rails.application.routes.draw do

  root 'tops#index'
  get '/privacy_policy', to: 'tops#privacy_policy'
  get '/terms', to: 'tops#terms'

  resources :fraud_reports, only: [:new, :create, :show]
  resources :scams, only: [:index, :show] do
    collection do
      get 'autocomplete'
    end
  end
  resources :users, only: [:new, :create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :posts do
    collection do
      get 'autocomplete'
    end
  end


  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
end
