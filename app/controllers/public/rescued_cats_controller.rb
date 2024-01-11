class Public::RescuedCatsController < ApplicationController
  def new
    @rescued_cat = RescuedCat.new
  end
  
  def create
    @rescued_cat = RescuedCat.new(rescued_cat_params)
    @rescued_cat.user_id = current_user.id
    @rescued_cat.save
    redirect_to rescued_cats_path
  end
  
  def index
    @user = current_user
    @rescued_cats = @user.rescued_cats
  end

  def show
    @rescued_cat = RescuedCat.find(params[:id])

  end

  def edit
    @rescued_cat = RescuedCat.find(params[:id])
  end
  
  
  def update
     @rescued_cat = RescuedCat.find(params[:id])
     if @rescued_cat.update(rescued_cat_params)
        redirect_to rescued_cat_path(@rescued_cat)
     else
        render :edit
     end
  end 
  
  
  def destroy
    rescued_cat = RescuedCat.find(params[:id])
    rescued_cat.destroy
    redirect_to rescued_cats_path
  end
  
   private

  def rescued_cat_params
    params.require(:rescued_cat).permit(:user_id, :title, :body, :name, :sex, :age, :vaccine, :is_completion, :is_castration, images: [])
  end
  
end
