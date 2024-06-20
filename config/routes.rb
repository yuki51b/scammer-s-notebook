# frozen_string_literal: true

Rails.application.routes.draw do

  resources :fraud_reports, only: [:new, :create, :show]
  resources :scams, only: [:index, :show]

  root 'tops#index'
end
