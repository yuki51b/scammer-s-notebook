# frozen_string_literal: true

Rails.application.routes.draw do

  root 'tops#index'

  resources :fraud_reports, only: [:new, :create, :show]
  resources :scams, only: [:index, :show]
  resources :users, only: [:new, :create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

end
