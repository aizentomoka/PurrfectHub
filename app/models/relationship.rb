class Relationship < ApplicationRecord
    
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"  
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    notifications.create(user_id: follower_id)
  end
  
end
