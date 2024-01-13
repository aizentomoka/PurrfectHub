class Public::UsersController < ApplicationController
  
  before_action :ensure_guest_user, only: [:edit, :confirm_withdraw]
  
  
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

  # 退会確認画面
  def confirm_withdraw
  end
  
  # 退会機能
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  # いいねした日記一覧
  def favorites 
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:diary_id)
    @favorite_diaries = Diary.find(favorites)
    @diary = Diary.find(params[:id])
  end
  
  # ブックマークした里親募集一覧
  def bookmarks 
    @user = User.find(params[:id])
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:rescued_cat_id)
    @bookmark_rescued_cats = RescuedCat.find(bookmarks)
    @rescued_cat = RescuedCat.find(params[:id])
  end
  
  # ログインユーザーの日記一覧
  def diaries
    @user = current_user
    @diaries = @user.diaries
  end
  
   # ログインユーザーの里親募集一覧
  def rescued_cats
    @user = current_user
    @rescued_cats = @user.rescued_cats
  end
  
  # ログインユーザーのマイページ
  def my_page
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  private
   
   def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to root_path, notice: "ゲストユーザーは閲覧、コメントのみ可能です。"
    end
   end  
  
  
  
   def user_params
      params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email, :profile_image)
   end
  
end
