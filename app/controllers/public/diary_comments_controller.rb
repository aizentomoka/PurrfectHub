class Public::DiaryCommentsController < ApplicationController
  
  def create
    @diary = Diary.find(params[:diary_id])
    comment = current_user.diary_comments.new(diary_comment_params)
    comment.diary_id = @diary.id
    if comment.save
    else
      redirect_to request.referer
      flash[:alert] = comment.errors.full_messages.join(', ')
    end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    comment = @diary.diary_comments.find(params[:id])
    if comment.destroy
    else
      redirect_to request.referer
      flash[:alert] = comment.errors.full_messages.join(', ')
    end  
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:comment)
  end

 
end
