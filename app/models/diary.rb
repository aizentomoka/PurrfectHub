class Diary < ApplicationRecord
    
    
    
 has_many_attached :images
 

 belongs_to :user
 belongs_to :cat, optional: true
 
 has_many :diary_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :favorited_users, through: :favorites, source: :user
 has_many :taggings, dependent: :destroy
 has_many :tags, through: :taggings
 
 scope :latest, -> { order(created_at: :desc) }  #latest = 新着順, desc = 降順
 scope :old, -> { order(created_at: :asc) }  #old = 古い順, asc = 昇順
 scope :most_favorited, -> { includes(:favorited_users)
   .sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse } #most_favorited = いいね順(多い順)
 
 validates :title, length: {maximum: 30}, presence: true
 validates :body, length: {maximum: 3000}, presence: true

 
 
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def create_tags(input_tags)
    input_tags.each do |tag|                     # splitで分けたtagをeach文で取得する
      new_tag = Tag.find_or_create_by(name: tag) # tagモデルに存在していれば、そのtagを使用し、なければ新規登録する
      tags << new_tag                            # 登録するdiaryのtagに紐づける（中間テーブルにも反映される）
    end
  end
  
  
  def update_tags(input_tags)
     registered_tags = tags.pluck(:name) # すでに紐付けれらているタグを配列化する
     new_tags = input_tags - registered_tags # 追加されたタグ
     destroy_tags = registered_tags - input_tags # 削除されたタグ
    
     new_tags.each do |tag| # 新しいタグをモデルに追加
      new_tag = Tag.find_or_create_by(name: tag)
      tags << new_tag
     end
    
     destroy_tags.each do |tag| # 削除されたタグを中間テーブルから削除
       tag_id = Tag.find_by(name: tag)
       destroy_tagging = Tagging.find_by(tag_id: tag_id, diary_id: id)
       destroy_tagging.destroy
     end
  end










end
