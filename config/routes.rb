Rails.application.routes.draw do

  get 'purchase/index'
  get 'purchase/done'
  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :show, :new] do
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

  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'

    end
  end
end











  # resources :cards, only: [:new, :show, :edit, :create] do
  #   collection do
  #     post 'show', to: 'cards#show'
  #     post 'pay', to: 'cards#pay'
  #     post 'delete', to: 'cards#delete'
  #   end
  # end