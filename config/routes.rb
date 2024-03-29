# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :commits
    resources :users
    resources :groups
    resources :links
    resources :devise_api_tokens
    resources :thoughts

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      resources :commits, only: [:create]
      resources :links, only: [:create]
      resources :emails, only: [:create]
      resources :groups
      get 'commits/grouped_by_repo', to: 'commits#grouped_by_repo'
      get 'commits/by_date/:date', to: 'commits#by_date'
      get 'links/search', to: 'links#search'
      get 'thoughts/weekly', to: 'thoughts#weekly'

      match '*unmatched_route', to: 'base#not_found', via: :all
    end
  end

  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
