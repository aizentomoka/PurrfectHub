class Admin::DiariesController < ApplicationController
  def index
       @diaries = Diary.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:cat_id, :user_id, :title, :body, :weight, images: [])
  end

end
