class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
  end

def create
  @category = Category.new(category_params)
  if @category.save
    flash[:notice] = "創建成功"
    redirect_to admin_categories_path
  else
    @categories = Category.all
    render :index
  end
end

def update
  set_category
  if @category.update(category_params)
    redirect_to admin_categories_path
    flash[:notice] = "category was successfully updated"
  else
    @categories = Category.all
    render :index
  end
end

def destroy
   set_category
   @category.destroy
   flash[:alert] = "category was successfully deleted"
   redirect_to admin_categories_path
 end

private

def set_category
  @category = Category.find(params[:id])
end

def category_params
  params.require(:category).permit(:name)
end



end
