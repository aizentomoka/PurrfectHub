class Relationship < ApplicationRecord
    
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"  
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    create_notification(user_id: follower_id)
  end
  
  def notification_message
     "#{followed.nickname}さんにフォローされました"
  end

  def notification_path
     my_page_user_path(follower.id) # フォローに対する通知の場合はフォローをしたUserのマイページへ
  end
  
end
