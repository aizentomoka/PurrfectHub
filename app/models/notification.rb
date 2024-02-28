class Notification < ApplicationRecord

  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  
  def message
    notifiable.notification_message
  end

  def notifiable_path
    notifiable.notification_path
  end
 
 
end
