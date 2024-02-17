class Public::RescuedCatCommentsController < ApplicationController
    
  def create
    rescued_cat = RescuedCat.find(params[:rescued_cat_id])
    comment = current_user.rescued_cat_comments.new(rescued_cat_comment_params)
    comment.rescued_cat_id = rescued_cat.id
    comment.save
    unless comment.save
      flash[:alert] = comment.errors.full_messages.join(', ')
      redirect_to request.referer
    end
  end



  def destroy
    RescuedCatComment.find(params[:id]).destroy
  end




  private

  def rescued_cat_comment_params
    params.require(:rescued_cat_comment).permit(:comment)
  end

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end
