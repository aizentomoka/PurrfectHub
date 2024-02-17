class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @diary = Diary.find(params[:diary_id])
    favorite = current_user.favorites.new(diary_id: @diary.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = current_user.favorites.find_by(diary_id: @diary.id)
    favorite.destroy
    # redirect_to request.referer
  end
  
end
