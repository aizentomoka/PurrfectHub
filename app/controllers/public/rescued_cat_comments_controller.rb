class Public::RescuedCatCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]  
  
  def create
    @rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    comment = current_user.rescued_cat_comments.new(rescued_cat_comment_params)
    comment.rescued_cat_id = @rescued_cat.id
    if comment.save
    else
      redirect_to request.referer
      flash[:alert] = comment.errors.full_messages.join(', ')
    end
  end

  def destroy
    @rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    comment = @rescued_cat.rescued_cat_comments.find(params[:id])
    if comment.destroy
    else
      redirect_to request.referer
      flash[:alert] = comment.errors.full_messages.join(', ')
    end  
  end




  private

  def rescued_cat_comment_params
    params.require(:rescued_cat_comment).permit(:comment)
  end
  
  def is_matching_login_user
    @rescued_cat = RescuedCat.find(params[:id])
    unless  @rescued_cat.user.id == current_user.id 
      redirect_to root_path
    end
  end
 
end
