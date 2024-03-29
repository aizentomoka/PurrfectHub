class Diary < ApplicationRecord
    
    
    
 has_many_attached :images
 

 belongs_to :user
 belongs_to :cat, optional: true
 
 has_many :diary_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :favorited_users, through: :favorites, source: :user
 has_many :taggings, dependent: :destroy
 has_many :tags, through: :taggings
 
 has_many :notifications, as: :notifiable, dependent: :destroy
 
 scope :latest, -> { order(created_at: :desc) }  #latest = 新着順, desc = 降順
 scope :old, -> { order(created_at: :asc) }  #old = 古い順, asc = 昇順
 scope :most_favorited, -> { includes(:favorited_users)
   .sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse } #most_favorited = いいね順(多い順)
 
 validates :title, length: {maximum: 30}, presence: true
 validates :body, length: {maximum: 3000}, presence: true
 
 enum weather: { sunny: 0, cloudy: 1, rainy: 2, snowy: 3, foggy: 4, typhoon: 5, thunder: 6 }
 
  def favorited_by?(user)
     return false if user.nil?
    favorites.exists?(user_id: user.id)
  end


  def create_tags(input_tags)
    input_tags.each do |tag|     # splitで分けたtagをeach文で取得する
     if tag.length <= 6      #6文字以内で作成 
        new_tag = Tag.find_or_create_by(name: tag)     # tagモデルに存在していれば、そのtagを使用し、なければ新規登録する
        tags << new_tag     # 登録するdiaryのtagに紐づける（中間テーブルにも反映される）
     end
    end
  end
  
  
  def update_tags(input_tags)
     registered_tags = tags.pluck(:name) # すでに紐付けれらているタグを配列化する
     new_tags = input_tags - registered_tags # 追加されたタグ
     destroy_tags = registered_tags - input_tags # 削除されたタグ
    
     new_tags.each do |tag| # 新しいタグをモデルに追加
      if tag.length <= 6  #6文字以内で作成
        new_tag = Tag.find_or_create_by(name: tag)
        tags << new_tag
      end
    end
    
     destroy_tags.each do |tag| # 削除されたタグを中間テーブルから削除
       tag_id = Tag.find_by(name: tag)
       destroy_tagging = Tagging.find_by(tag_id: tag_id, diary_id: id)
       destroy_tagging.destroy
     end
  end




end
