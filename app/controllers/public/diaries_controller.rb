class Public::DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end
  
  def create
    @diary = Diary.new(cat_params)
    @diary.user.id = current_user.id
    @diary.save
    redirect_to diaries_path
  end
  
  def index
    @user = current_user
    @diaries = @user.diaries
    @cat = Cat.find(params[:id])
    @cat.user_id = current_user.id
  end


  def show
    @diaries = Diaries.find(params[:id])
  end

  def edit
    @diaries = Diaries.find(params[:id])
  end
  
  def update
     @diary = Diary.find(params[:id])
     if @diary.update(diary_params)
        redirect_to diary_path(@diary)
     else
        render :edit_diary_path
     end
  end 
  
  private

  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight)
  end
  
end
