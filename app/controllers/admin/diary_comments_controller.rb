class Admin::DiaryCommentsController < ApplicationController

  def index
    @diary_comments = DiaryComment.all
    @users = User.all
  end

 
  def destroy
    DiaryComment.find(params[:id]).destroy
    redirect_to admin_diary_comments_path
  end






  private

  def diary_comment_params
    params.require(:diary_comment).permit(:comment)
  end






end