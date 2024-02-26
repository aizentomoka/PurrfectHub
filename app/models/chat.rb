class Chat < ApplicationRecord
    
  belongs_to :user
  belongs_to :room

  has_many :notifications, as: :notifiable, dependent: :destroy
 
  validates :message, presence: true, length: { maximum: 150}
  
  after_create do
    notifications.create(user_id: follower.id)
  end
  
end
