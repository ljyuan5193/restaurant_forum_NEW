Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: :show
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :friend_list
        end
          end
  resources :followships, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
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
    get :ranking
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

end
