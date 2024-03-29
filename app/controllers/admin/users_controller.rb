class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_user_path(@user)
    else
      flash[:notice] = "編集に失敗しました。"
      @user = User.find(params[:id])
      render :edit
    end
  end 
  
  private
  
   def user_params
      params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :is_active)
   end
  
    
  
end
