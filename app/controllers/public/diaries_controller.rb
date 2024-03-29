class Public::DiariesController < ApplicationController
  before_action :authenticate_user!, except: [ :index]
  before_action :ensure_guest_user, only: [:new, :edit, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @diary = Diary.new
    @cats = current_user.cats
  end
  
  def create
    @cats = current_user.cats
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    input_tags = tag_params[:name].split('/')  # tag_paramsをsplitメソッドを用いて配列に変換
    @diary.create_tags(input_tags)  # create_tagsはdiary.rbにメソッドを記載
    if @diary.save
      flash[:notice] = "投稿に成功しました"
      redirect_to diary_path(@diary)
    else
      flash.now[:alert] = "投稿に失敗しました"
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
    @user = @diary.user
    @diary_comment = DiaryComment.new
  end

  def edit
    @cats = current_user.cats
  end
  
  def update
     @cats = current_user.cats
     if @diary.update(diary_params)
        input_tags = tag_params[:name].split('/')
        @diary.update_tags(input_tags) # udpate_tagsはdiary.rbに記述している
        flash[:notice] = "編集に成功しました"
        redirect_to diary_path(@diary)
     else
        flash[:alert] = "編集に失敗しました" 
        render :edit
     end
  end 
  
  
  def destroy
    @diary.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to diaries_user_path(current_user)
  end
  
  # 検索機能
  def search
    if params[:keyword].present? #keywordが存在する場合
      @diaries = Diary.where('body LIKE ?', "%#{params[:keyword]}%").order(created_at: :desc).page(params[:page])  #本文で部分一致する投稿を新規順で取り出す
      @keyword = params[:keyword]
    else
      @diaries = Diary.all
    end
  end
  
  # タグ検索機能
  def tag_search
     @tag_name = params[:name]
     @diaries = Diary.joins(:tags).where(tags: { name: @tag_name }).page(params[:page]).order(created_at: :desc)
  end 
  
  
  private
  
  
 
  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight, images: [])
  end
  
  def tag_params 
      params.require(:diary).permit(:name)
  end
 
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash[:alert] = "ログインが必要です"
      redirect_to request.referer
    end
  end  
  def is_matching_login_user
     @diary = Diary.find(params[:id])
    unless  @diary.user.id == current_user.id 
      redirect_to root_path
    end
  end
end
