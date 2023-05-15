# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :commits
    resources :users
    resources :groups
    resources :links
    resources :devise_api_tokens

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
        resources :commits, only: [:create]
        resources :groups
        get 'commits/grouped_by_repo', to: 'commits#grouped_by_repo'
        get 'commits/by_date/:date', to: 'commits#by_date'
        get 'links/search', to: 'links#search'
    end
  end

  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
