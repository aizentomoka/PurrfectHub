class Public::CatsController < ApplicationController
  before_action :ensure_guest_user, only: [:new, :create, :edit]
  
  def new
    @cat = Cat.new
  end
 
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      flash[:notice] = "登録に成功しました。"
      redirect_to cats_path
    else
      flash.now[:alert] = "登録に失敗しました。"   
      render :new
    end
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
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash.now[:alert] = "会員登録が必要です。"
      redirect_to root_path
    end
  end   
end
