class RescuedCatComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :rescued_cat
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :comment, length: {maximum: 500}, presence: true
  
  after_create do
    notifications.create(user_id: rescued_cat.user_id)
  end
  
  def notification_message
    "#{user.nickname}さんが#{rescued_cat.title}にコメントしました"
  end

  def notification_path
     rescued_cat_path(rescued_cat.id) # コメントに対する通知の場合は里親募集の詳細ページへ
  end
  
end
