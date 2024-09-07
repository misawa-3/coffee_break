Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  patch 'users/update_user_name', to: 'users#update_user_name', as: :update_user_name

  patch 'users/update_user_image', to: 'users#update_user_image', as: :update_user_image
  
  resources :posts, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :update]
end
