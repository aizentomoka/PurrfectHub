class RescuedCat < ApplicationRecord
    
 has_many_attached :images
 belongs_to :user
 has_many :rescued_cat_comments, dependent: :destroy
 
 
end
