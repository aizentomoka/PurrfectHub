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
  end

  def edit
  end
  
  def update
    @cat = Cat.new
  end
  
   private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birthday, :image)
  end
  
end
