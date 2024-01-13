class Tag < ApplicationRecord
    
  has_many :taggings, dependent: :destroy
  has_many :diaries,   through: :taggings  
 
end
