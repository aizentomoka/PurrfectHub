class Admin::UsersController < ApplicationController
  def index
    @users = User.all
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
      redirect_to admin_users_path, notice: "編集に成功しました！"
    else
      @user = User.find(params[:id])
      render :edit_admin_user_path
    end
  end 
  
  private
  
   def user_params
      params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :is_active)
   end
  
    
  
end
