class Admin::RescuedCatCommentsController < ApplicationController
  
  def index
    @rescued_cat_comments = RescuedCatComment.all
    @users = User.all
  end

 
  def destroy
    RescuedCatComment.find(params[:id]).destroy
    redirect_to admin_rescued_cat_rescued_cat_comments_path
  end


  private

  def rescued_cat_comment_params
    params.require(:rescued_cat_comment).permit(:comment)
  end

end
