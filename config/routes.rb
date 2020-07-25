Rails.application.routes.draw do
  root 'messages#index'
  resources :messages, only: [:index] do
    collection do
      get 'index2', 'index3', 'index4', 'index5'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
