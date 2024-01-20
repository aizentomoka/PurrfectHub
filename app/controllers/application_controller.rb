class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:top, :about, :index]
    before_action :is_matching_login_user, only: [:edit, :update]
    
    
    
    
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
    
    
    
    
end
