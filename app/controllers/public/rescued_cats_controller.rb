class Public::RescuedCatsController < ApplicationController
  before_action :ensure_guest_user, only: [:new, :create, :edit, :destroy]
  
  def new
    @rescued_cat = RescuedCat.new
  end
  
  def create
    @rescued_cat = RescuedCat.new(rescued_cat_params)
    @rescued_cat.user_id = current_user.id
    input_labels = params[:rescued_cat][:label_name].split('/') # label_paramsをsplitメソッドを用いて配列に変換
    @rescued_cat.create_labels(input_labels)  # create_labelsはrescued_cat.rbにメソッドを記載
    if @rescued_cat.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to rescued_cat_path(@rescued_cat)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end
  
  def index
    @rescued_cats = RescuedCat.all
  end

  def show
    @rescued_cat = RescuedCat.find(params[:id])
    @rescued_cat_comment = RescuedCatComment.new

  end

  def edit
   @rescued_cat = RescuedCat.find(params[:id])
  # @label_names = @rescued_cat.labels.pluck(:name).join('/')
  # puts "Tag Names: #{@tag_names}"
  # @label_names = @rescued_cat.labels.pluck(:name).join('/')
  # @label_names = @rescued_cat.label_name
  end
  
  
  def update
     @rescued_cat = RescuedCat.find(params[:id])
     if @rescued_cat.update(rescued_cat_params)
        input_labels = label_params[:name].split('/')
        @rescued_cat.update_labels(input_labels) # udpate_labelsはrescued_cat.rbに記述している
        flash[:notice] = "編集に成功しました。"
        redirect_to request.referer
     else
        flash.now[:alert] = "編集に失敗しました。" 
        render :edit
     end
  end 
  
  
  def destroy
    rescued_cat = RescuedCat.find(params[:id])
    rescued_cat.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to rescued_cats_path
  end
  
  # 検索機能
  def search
    if params[:keyword].present?
      @rescued_cats = RescuedCat.where('body LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @rescued_cats = RescuedCat.all
    end
  end
  
   
  # ラベル検索機能
  def label_search
     @label_name = params[:name]
     @rescued_cats = RescuedCat.joins(:labels).where(labels: { name: @label_name })
  end 
  
  
  
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash.now[:alert] = "会員登録が必要です。"
      redirect_to root_path
    end
  end  
 
  def rescued_cat_params
    params.require(:rescued_cat).permit(:user_id, :title, :body, :name, :sex, :age, :vaccine, :is_completion, :is_castration, images: [])
  end
  
  def label_params 
      params.require(:rescued_cat).permit(:name)
  end
end
