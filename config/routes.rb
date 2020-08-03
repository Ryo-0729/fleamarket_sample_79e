Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    collection do
      get 'index2'
      get 'confirmation'
    end
  end

  resources :users, only: [:index, :new] do
    collection do
      get 'logout'
    end
  end

  resources :cards, only: [:new, :edit]
end