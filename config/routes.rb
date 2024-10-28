Rails.application.routes.draw do
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
  
  devise_for :users

  root to: "homes#top"

  patch 'users/update_user_name', to: 'users#update_user_name', as: :update_user_name
  patch 'users/update_user_image', to: 'users#update_user_image', as: :update_user_image
  
  namespace :admin do
    resources :users do
      member do
        post :reactivate
        post :deactivate
        post :freeze
      end
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      post :deactivate
      get :following, :followers
    end
  end

  get "search" => "searches#search"
  
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :favorites, only: [:index]
  
  resources :relationships, only: [:create, :destroy]
end