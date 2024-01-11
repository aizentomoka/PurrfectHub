class Public::CatsController < ApplicationController
  
  
  def new
    @cat = Cat.new
  end
 
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    @cat.save
    redirect_to cats_path
  end
 
 
  def index
    @user = current_user
    @cats = @user.cats
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def edit
    @cat = Cat.find(params[:id])
  end 
  
  
  def update
     @cat = Cat.find(params[:id])
     if @cat.update(cat_params)
        redirect_to cat_path(@cat)
     else
        render :edit
     end
  end 

  
   private

  def cat_params
    params.require(:cat).permit(:user_id, :name, :sex, :birthday, :image)
  end
  
end
