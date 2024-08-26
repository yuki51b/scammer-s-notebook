# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tops#index'
  get '/privacy_policy', to: 'tops#privacy_policy'
  get '/terms', to: 'tops#terms'
  get '/line_notify', to: 'tops#line_notify'
  get '/list_of_support', to: 'tops#list_of_support'

  resource :profile, only: %i[edit show update]

  resources :fraud_reports, only: %i[new create show]

  resources :scams, only: %i[index show] do
    collection do
      get 'autocomplete'
    end
  end

  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  resources :posts do
    collection do
      get 'autocomplete'
    end
  end

  namespace :admin do
    root 'scams#index'
    resources :scams
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => 'user_sessions#create'
    delete 'logout' => 'user_sessions#destroy', :as => :logout
  end

  get 'images/ogp.png', to: 'images#ogp', as: 'images_ogp'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
end
