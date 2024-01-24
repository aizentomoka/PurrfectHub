class Admin::RescuedCatsController < ApplicationController
  def index
    @rescued_cats = RescuedCat.page(params[:page])
  end
  

  def destroy
    rescued_cat = RescuedCat.find(params[:id])
    rescued_cat.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_rescued_cats_path
  end
  
    private

  def rescued_cat_params
    params.require(:rescued_cat).permit(:user_id, :title, :body, :name, :sex, :age, :vaccine, :is_completion, :is_castration, images: [])
  end
  
end
