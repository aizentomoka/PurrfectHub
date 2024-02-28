class DiaryComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :diary
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :comment, length: {maximum: 500}, presence: true
  
  after_create do
    notifications.create(user_id: diary.user_id)
  end
  
  def notification_message
    "#{user.nickname}さんが#{diary.title}にコメントしました"
  end

  def notification_path
     diary_path(diary.id) # コメントに対する通知の場合は日記の詳細ページへ
  end
      
end
