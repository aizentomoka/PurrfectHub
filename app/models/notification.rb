class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers 
  
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  
 
  
  def message
    if notifiable_type === "DiaryComment"
      "#{notifiable.user.nickname}さんが#{notifiable.diary.title}にコメントしました"
    elsif notifiable_type === "RescuedCatComment"
      "#{notifiable.user.nickname}さんが#{notifiable.rescued_cat.title}にコメントしました"
    elsif notifiable_type === "Relationship"
      "#{notifiable.followed.nickname}さんにフォローされました"
    else notifiable_type === "Chat"
      "#{notifiable.user.nickname}さんからDMが届きました"
    end
  end

  def notifiable_path
    if notifiable_type === "DiaryComment"
      diary_path(notifiable.diary.id) # コメントに対する通知の場合は日記の詳細ページへ
    elsif notifiable_type === "RescuedCatComment"
      rescued_cat_path(notifiable.rescued_cat.id) # コメントに対する通知の場合は里親募集の詳細ページへ
    elsif notifiable_type === "Relationship"
      my_page_user_path(notifiable.followed.id) # フォローに対する通知の場合はフォローをしたUserのマイページへ
    else notifiable_type === "Chat"
      chat_path(notifiable.user.id)# DMに対する通知の場合はDMをしたUserのマイページへ
    end
    
  end
end
