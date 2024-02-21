class Public::BookmarksController < ApplicationController
  
  def create
    if user_signed_in?
      @rescued_cat = RescuedCat.find(params[:rescued_cat_id])
      bookmark = current_user.bookmarks.new(rescued_cat_id: @rescued_cat.id)
      bookmark.save
    else
      flash[:alert] = "ログインもしくはアカウント登録してください。"
      redirect_to new_user_session_path # ログイン画面へのリダイレクト
    end  
  end

  def destroy
    @rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    bookmark = current_user.bookmarks.find_by(rescued_cat_id: @rescued_cat.id)
    bookmark.destroy
  end
  








end
