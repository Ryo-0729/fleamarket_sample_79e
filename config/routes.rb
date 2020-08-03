Rails.application.routes.draw do

  devise_for :users
  root 'items#index'

  
  resources :items, only: [:index, :show, :new, :create] do
    collection do
      get 'index2'
      post 'buy'

    end
    member do
      get 'confirmation'
    end

    # collection do
    #   get 'index2'
    #   # get 'confirmation'
    #   post 'pay', to: 'items#pay'
    #   get 'done', to: 'items#done'
    # end
    # member do
    #   get 'confirmation'
    # end

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