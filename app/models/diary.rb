class Diary < ApplicationRecord
    
    
    
 has_many_attached :images
 

 belongs_to :user
 belongs_to :cat
 
 has_many :diary_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :favorited_users, through: :favorites, source: :user
 
 
 scope :latest, -> { order(created_at: :desc) }  #latest = 新着順, desc = 降順
 scope :old, -> { order(created_at: :asc) }  #old = 古い順, asc = 昇順
 scope :most_favorited, -> { includes(:favorited_users)
   .sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse } #most_favorited = いいね順(多い順)
 
 
 
 
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
