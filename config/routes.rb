# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :groups
    resources :links
    resources :devise_api_tokens

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      resources :groups
    end
  end

  resources :groups
  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
