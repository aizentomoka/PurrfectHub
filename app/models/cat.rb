class Cat < ApplicationRecord
    
 has_one_attached :image
 belongs_to :user
 has_many :diaries, dependent: :destroy
    
 validates :name, length: {maximum: 20}, presence: true
 validates :sex, presence: true
 
 
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
    
end
