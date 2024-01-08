class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
         


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
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

  



end
