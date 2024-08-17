Rails.application.routes.draw do

 devise_for :users
 root to: "homes#top"
 resources :posts, only: [:new, :create, :index, :show, :destroy]
 resources :users, only: [:show, :edit, :update]
end
