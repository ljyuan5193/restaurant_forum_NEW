Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: :show
  root "restaurants#index"


  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

  resources :restaurants, only: [:index, :show] do
  resources :comments, only: [:create, :destroy]
  collection do
    get :feeds
  end

  # 瀏覽個別餐廳的 Dashboard
  member do
    get :dashboard
    post :favorite
    post :unfavorite
    post :like
    post :unlike
  end
end
resources :users, only: [:show, :edit, :update]
end
