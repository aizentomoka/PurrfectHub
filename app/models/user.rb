class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  
  has_many :cats, dependent: :destroy
  
  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :rescued_cats, dependent: :destroy
  has_many :rescued_cat_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  
   
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
