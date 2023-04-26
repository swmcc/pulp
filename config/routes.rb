Rails.application.routes.draw do
  resources :groups
  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
