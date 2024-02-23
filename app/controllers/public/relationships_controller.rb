class Public::RelationshipsController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]
  before_action :set_user 
  
  # フォローするとき
  def create
    if current_user.following?(params[:user_id])
      flash[:notice] = "既にフォロー済みです"
    else
      
      current_user.follow(params[:user_id])
    end
  end
  
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
  end  
    
  private
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash[:alert] = "会員登録が必要です。"
      redirect_to request.referer  
    end
  end  
       
  def set_user
     @user = User.find(params[:id])
  end

end
