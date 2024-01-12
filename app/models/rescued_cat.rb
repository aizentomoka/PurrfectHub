class RescuedCat < ApplicationRecord
    
 has_many_attached :images
 
 belongs_to :user
 
 has_many :rescued_cat_comments, dependent: :destroy
 has_many :bookmarks, dependent: :destroy
 
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end


end
