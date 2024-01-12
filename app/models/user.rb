class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cats, dependent: :destroy
  
  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :rescued_cats, dependent: :destroy
  has_many :rescued_cat_comments, dependent: :destroy
  
  
  
  
  
  
  
  
   
  def active_for_authentication?
    super && (is_active == true)
  end
       
         
  GUEST_MEMBER_EMAIL = "guest@example.com" 
  
  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
      user.id = 2222222222
      user.first_name = "ゲスト"
      user.last_name = "ユーザー"
      user.first_name_kana = "ゲスト"
      user.last_name_kana = "ユーザー"
      user.post_code = "2222222"
      user.address = "猫県猫市猫区22-22"
      user.telephone_number = "2222222222"
      user.created_at = Time.current
      user.updated_at = Time.current
    end
  end

   def guest_user?
    email == GUEST_MEMBER_EMAIL
   end





end
