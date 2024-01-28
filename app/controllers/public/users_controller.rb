class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:show, :edit, :confirm_withdraw]
  before_action :is_matching_login_user, only: [:edit, :update, :show]
  
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集を保存しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "編集に失敗しました"
      render :edit
    end
  end 

  # 退会確認画面
  def confirm_withdraw
  end
  
  # 退会機能
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  # いいねした日記一覧
  def favorites 
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:diary_id)
    @diaries = Diary.where(id: favorites).page(params[:page]).order(created_at: :desc)
    @favorite_diaries = @diaries
  end
  
  # ブックマークした里親募集一覧
  def bookmarks 
    @user = User.find(params[:id])
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:rescued_cat_id)
    @rescued_cats = RescuedCat.where(id: bookmarks).page(params[:page]).order(created_at: :desc)
    @bookmark_rescued_cats = @rescued_cats
  end
  
  # ユーザーの日記一覧
  def diaries
    @user = User.find(params[:id])
    @diaries = @user.diaries.page(params[:page]).order(created_at: :desc)
  end
  
  # ユーザーの里親募集一覧
  def rescued_cats
    @user = User.find(params[:id])
    @rescued_cats = @user.rescued_cats.page(params[:page]).order(created_at: :desc)
  end
  
  # ユーザーの猫一覧
  def cats
    @user = User.find(params[:id])
    @cats = @user.cats
  end
  
  # ユーザーのマイページ
  def my_page
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end
  
  # フォロー一覧
  def follows
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  # フォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end
 
  
  private
   
   def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash[:alert] = "会員登録が必要です。"
      redirect_to request.referer
    end
   end  
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id 
      redirect_to root_path
    end
  end
  
   def user_params
      params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email, :profile_image)
   end
  
  
  
  
end
