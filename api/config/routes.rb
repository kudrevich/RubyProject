Rails.application.routes.draw do

  post :user_token, to: 'user_token#create'
  resource :user
  get 'show_user/:id', to: 'users#show_user'

  resources :categories
  resources :subcategories

  resources :orders do
    put :start_execute, on: :collection
    put :confirm, on: :collection
  end
end