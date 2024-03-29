class Public::CatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:new, :create, :edit]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @cat = Cat.new
  end
 
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      flash[:notice] = "登録に成功しました。"
      redirect_to cats_user_path( @cat.user_id)
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])
    @user = @cat.user.id
  end

  def edit
  end 
  
  def update
     if @cat.update(cat_params)
        flash[:notice] = "編集に成功しました。"
        redirect_to cat_path(@cat)
     else
        flash.now[:alert] ="編集に失敗しました"
        render :edit
     end
  end 

  
  private
  
  def cat_params
    params.require(:cat).permit(:user_id, :name, :sex, :birthday, :image)
  end
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash[:alert] = "会員登録が必要です。"
      redirect_to request.referer
    end
  end   
  
  def is_matching_login_user
    @cat = Cat.find(params[:id])
    unless @cat.user.id == current_user.id 
      redirect_to root_path
    end
  end
end
