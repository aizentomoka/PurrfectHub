class HomesController < ApplicationController
  
  def top
    @rescued_cats = RescuedCat.order(created_at: :desc).take(4)
    to = Time.current.at_end_of_day #一週間のいいねがおおい順に表示
    from = (to - 6.day).at_beginning_of_day
    @diaries = Diary.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
       .take(3)
 
    @newdiaries = Diary.order(created_at: :desc).take(4) #新規順の投稿
    @tag_name = "おなやみ"
    @diary_questions = Diary.joins(:tags).where(tags: { name: @tag_name }).limit(4) #おなやみ相談の投稿
  end
  
  
  
  def about
  end
  
  
  
  
end
