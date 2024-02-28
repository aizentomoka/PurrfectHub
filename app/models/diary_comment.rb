class DiaryComment < ApplicationRecord
  
    
  belongs_to :user
  belongs_to :diary
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :comment, length: {maximum: 500}, presence: true
  
  after_create do
    notifications.create(user_id: diary.user_id)
  end
  
end
