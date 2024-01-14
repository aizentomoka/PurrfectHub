class Public::DiariesController < ApplicationController
  
  def new
    @diary = Diary.new
    @cats = current_user.cats
  end
  
  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    input_tags = tag_params[:name].split('/')  # tag_paramsをsplitメソッドを用いて配列に変換
    @diary.create_tags(input_tags)  # create_tagsはtopic.rbにメソッドを記載
    @diary.save
    redirect_to diary_path(@diary)
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
        input_tags = tag_params[:name].split('/')
        @diary.update_tags(input_tags) # udpate_tagsはtopic.rbに記述している
        redirect_to request.referer
     else
        render :edit
     end
  end 
  
  
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to diaries_path
  end
  
  # 検索機能
  def search
    if params[:keyword].present?
      @diaries = Diary.where('body LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @diaries = Diary.all
    end
  end
  
  # タグ検索機能
  def tag_search
     @tag_name = params[:name]
     @diaries = Diary.joins(:tags).where(tags: { name: @tag_name })
  end 
  
  
  private

  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight, images: [])
  end
  
  def tag_params 
      params.require(:diary).permit(:name)
  end
end
