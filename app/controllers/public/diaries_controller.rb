class Public::DiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_guest_user, only: [:new, :edit, :destroy]
  
  def new
    @diary = Diary.new
    @cats = current_user.cats
  end
  
  def create
    @cats = current_user.cats
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    input_tags = tag_params[:name].split('/')  # tag_paramsをsplitメソッドを用いて配列に変換
    @diary.create_tags(input_tags)  # create_tagsはtopic.rbにメソッドを記載
    if @diary.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to diary_path(@diary)
    else
      flash.now[:alert] = "投稿に失敗しました。" 
      render :new
    end
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
        flash[:notice] = "編集に成功しました。"
        redirect_to request.referer
     else
        flash.now[:alert] = "投稿に失敗しました。" 
        render :edit
     end
  end 
  
  
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = "投稿を削除しました。"
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
 
  def ensure_guest_user
    if current_user.guest_user?
      flash.now[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to root_path
    end
  end  
  
end
