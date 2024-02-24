class Guestuser::DataGuest
    
  # guestuserの投稿を削除
  def self.data_reset
    user = User.find_by(email: GUEST_MEMBER_EMAIL)
    user.favorites.destroy_all
    user.bookmsrks.destroy_all
    user.driary_comments.destroy_all
    user.rescued_cat_comments.destroy_all
  end
  
end