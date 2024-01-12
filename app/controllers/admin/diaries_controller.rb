class Admin::DiariesController < ApplicationController
  def index
     if params[:latest]
      @diaries = Diary.latest   #新着順
     elsif params[:old]
       @diaries = Diary.old   #古い順
     elsif params[:most_favorited]   #人気順
       @diaries = Diary.most_favorited
     else
       @diaries = Diary.all
     end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to admin_diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight, images: [])
  end

end
