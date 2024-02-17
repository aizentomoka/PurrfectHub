class Public::FavoritesController < ApplicationController
  
 def create
    if user_signed_in?
      @diary = Diary.find(params[:diary_id])
      favorite = current_user.favorites.new(diary_id: @diary.id)
      favorite.save
    else
      flash[:alert] = "ログインもしくはアカウント登録してください。"
      redirect_to new_user_session_path # ログイン画面へのリダイレクト
    end
 end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = current_user.favorites.find_by(diary_id: @diary.id)
    favorite.destroy
  end
end