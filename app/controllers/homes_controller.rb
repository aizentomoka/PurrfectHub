class HomesController < ApplicationController
  
  def top
    to = Time.current.at_end_of_day #一週間のいいねがおおい順に表示
    from = (to - 6.day).at_beginning_of_day
    @diaries = Diary.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
       .take(3)
  end

  def about
  end
  
  
  
  
end
