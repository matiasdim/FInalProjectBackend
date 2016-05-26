Rails.application.routes.draw do

  resources :reports
  resources :pets
  devise_for :users

  post '/users/create' => 'user#create'
  put '/users/update' => 'user#update'
  root to: "home#index"
end
