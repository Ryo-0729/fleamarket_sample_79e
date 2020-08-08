Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :items do
    collection do
      get 'category_lists'
      get 'confirmation'
      get 'search'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'category_item_lists'
      get 'confirmation'
      post 'buy'
      get 'card'
    end
  end

  resources :users, only: [:index, :new] do
    collection do
      get 'logout'
    end
  end

  resources :cards, only: [:new, :show, :destroy, :edit] do
    collection do
      post 'pay', to: 'cards#pay'

    end
  end
end