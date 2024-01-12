class Public::DiariesController < ApplicationController
  
  def new
    @diary = Diary.new
    @cats = current_user.cats
  end
  
  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    @diary.save
    redirect_to diaries_user_path(@diary)
  end
  
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


  def show
    @diary = Diary.find(params[:id])
    @cats = current_user.cats
    @diary_comment = DiaryComment.new
  end

  def edit
    @diary = Diary.find(params[:id])
    @cats = current_user.cats
  end
  
  def update
     @diary = Diary.find(params[:id])
     @cats = current_user.cats
     if @diary.update(diary_params)
        redirect_to diary_path(@diary)
     else
        render :edit
     end
  end 
  
  
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to diaries_path
  end
  
  
  
  
  
  
  private

  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight, images: [])
  end
  
end
