class Diary < ApplicationRecord
    
    
    
 has_many_attached :images
 

 belongs_to :user
 belongs_to :cat
 
 has_many :diary_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 
 
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
