# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :groups

    root to: 'users#index'
  end
  resources :groups
  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
