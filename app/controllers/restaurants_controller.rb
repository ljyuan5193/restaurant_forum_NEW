class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all     # 加上這一行
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
   @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
   @recent_comments = Comment.order(created_at: :desc).limit(10)
 end

 def dashboard
   @restaurant = Restaurant.find(params[:id])
 end

 def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.favorites_count += 1
    @restaurant.save!
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unfavorite
  @restaurant = Restaurant.find(params[:id])
  favorite = Favorite.where(restaurant: @restaurant, user: current_user)
  favorite.destroy_all
  @restaurant.favorites_count -= 1
  @restaurant.save!
  redirect_back(fallback_location: root_path)
end

def like
   @restaurant = Restaurant.find(params[:id])
   @restaurant.like.create!(user: current_user)
   redirect_back(fallback_location: root_path)  # 導回上一頁
 end

 def unlike
 @restaurant = Restaurant.find(params[:id])
 like = Like.where(restaurant: @restaurant, user: current_user)
 like.destroy_all
 redirect_back(fallback_location: root_path)
end

def ranking
@recent_favorites_counts = Restaurant.order(favorites_count: :desc).limit(10)
end

end
