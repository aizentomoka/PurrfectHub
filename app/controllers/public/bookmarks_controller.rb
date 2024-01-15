class Public::BookmarksController < ApplicationController
  
  def create
    rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    bookmark = current_user.bookmarks.new(rescued_cat_id: rescued_cat.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    bookmark = current_user.bookmarks.find_by(rescued_cat_id: rescued_cat.id)
    bookmark.destroy
   redirect_to request.referer
  end
  

end