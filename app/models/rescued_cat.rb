class RescuedCat < ApplicationRecord
    
 has_many_attached :images
 
 belongs_to :user
 
 has_many :rescued_cat_comments, dependent: :destroy
 has_many :bookmarks, dependent: :destroy
 has_many :labelings, dependent: :destroy
 has_many :labels, through: :labelings
 
 validates :name, length: {maximum: 10}
 validates :age, length: {maximum: 3000}, presence: true
 validates :sex, presence: true
 validates :title, length: {maximum: 30}, presence: true
 validates :body, length: {maximum: 3000}, presence: true
 validates :vaccine, length: {maximum: 100}, presence: true

  def bookmarked_by?(user)
    return false if user.nil?
    bookmarks.exists?(user_id: user.id)
  end

  def create_labels(input_labels)
    input_labels.each do |label|                     # splitで分けたlabelをeach文で取得する
      new_label = Label.find_or_create_by(name: label) # labelモデルに存在していれば、そlabelを使用し、なければ新規登録する
      labels << new_label                            # 登録するdiaryのlabelに紐づける（中間テーブルにも反映される）
    end
  end
  
  
  def update_labels(input_labels)
     registered_labels = labels.pluck(:name) # すでに紐付けれらているラベルを配列化する
     new_labels = input_labels - registered_labels # 追加されたラベル
     destroy_labels = registered_labels - input_labels # 削除されたラベル
    
     new_labels.each do |label| # 新しいラベルをモデルに追加
      new_label = Label.find_or_create_by(name: label)
      labels << new_label
     end
    
     destroy_labels.each do |label| # 削除されたラベルを中間テーブルから削除
       label_id = Label.find_by(name: label)
       destroy_labeling = Labeling.find_by(label_id: label_id, rescued_cat_id: id)
       destroy_labeling.destroy
     end
  end


end
