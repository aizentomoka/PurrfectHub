class Public::DiaryCommentsController < ApplicationController
  
  def create
    diary = Diary.find(params[:diary_id])
    comment = current_user.diary_comments.new(diary_comment_params)
    comment.diary_id = diary.id
    if comment.save
      redirect_to diary_path(diary)
    else
      flash[:alert] = comment.errors.full_messages.join(', ')
      redirect_to request.referer
    end
  end



  def destroy
    DiaryComment.find(params[:id]).destroy
    redirect_to diary_path(params[:diary_id])
  end








  private

  def diary_comment_params
    params.require(:diary_comment).permit(:comment)
  end

 
end
