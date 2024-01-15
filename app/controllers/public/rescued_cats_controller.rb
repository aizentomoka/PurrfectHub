class Public::RescuedCatsController < ApplicationController
  def new
    @rescued_cat = RescuedCat.new
  end
  
  def create
    @rescued_cat = RescuedCat.new(rescued_cat_params)
    @rescued_cat.user_id = current_user.id
    input_labels = params[:rescued_cat][:label_name].split('/') # label_paramsをsplitメソッドを用いて配列に変換
    @rescued_cat.create_labels(input_labels)  # create_labelsはrescued_cat.rbにメソッドを記載
    @rescued_cat.save
    redirect_to rescued_cat_path(@rescued_cat)
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
        redirect_to request.referer
     else
        render :edit
     end
  end 
  
  
  def destroy
    rescued_cat = RescuedCat.find(params[:id])
    rescued_cat.destroy
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

  def rescued_cat_params
    params.require(:rescued_cat).permit(:user_id, :title, :body, :name, :sex, :age, :vaccine, :is_completion, :is_castration, images: [])
  end
  
  def label_params 
      params.require(:rescued_cat).permit(:name)
  end
end
