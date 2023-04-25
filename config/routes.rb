Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  devise_for :users
  root 'welcome#index'
end
