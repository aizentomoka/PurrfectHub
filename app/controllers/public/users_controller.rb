class Public::UsersController < ApplicationController
  
  before_action :ensure_guest_user, only: [:edit]
  
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit_user_path
    end
  end 
  
  
  
  
  
  def confirm_withdraw
  end
  
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  
  
  
  
   private
   
   
   def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to root_path, notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
   end  
  
   private
  
   def user_params
      params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
   end
  
end