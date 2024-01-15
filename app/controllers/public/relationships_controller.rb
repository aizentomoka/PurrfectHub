class Public::RelationshipsController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]
  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end  
    
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash.now[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to root_path
    end
  end  
  
end
