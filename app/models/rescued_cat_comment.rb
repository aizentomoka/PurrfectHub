class RescuedCatComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :rescued_cat
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :comment, length: {maximum: 500}, presence: true
  
  after_create do
    notifications.create(user_id: rescued_cat.user_id)
  end
  
end
