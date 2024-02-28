class Chat < ApplicationRecord
    
  belongs_to :user
  belongs_to :room

  has_many :notifications, as: :notifiable, dependent: :destroy
 
  validates :message, presence: true, length: { maximum: 150}
  
  after_create do
    target_user_id= UserRoom.where(room_id: room_id).where.not(user_id: user_id).first.user_id
    notifications.create(user_id: target_user_id)
  end
  
  def notification_message
      "#{user.nickname}さんからDMが届きました"
  end

  def notification_path
      chat_path(user.id)# DMに対する通知の場合はDMをしたUserのマイページへ
  end
  
end
