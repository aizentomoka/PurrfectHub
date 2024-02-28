class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!  
    
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notifiable_path
  end  
    
end
