Rails.application.routes.draw do
  devise_for :users
  #deviseはresourseより上に置く
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root 'home#top'
  get 'home/about'
  post 'home/logout'
end
