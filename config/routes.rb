Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :new, :create] do
    collection do
      get 'index2'
    end
  end

  resources :users, only: [:index, :new] do
    collection do
      get 'logout'
    end
  end

  resources :cards, only: [:new, :edit]
end