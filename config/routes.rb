Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :show, :new]
  resources :users, only: [:index, :new]
  resources :cards, only: [:new, :edit]
end
