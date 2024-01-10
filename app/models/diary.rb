class Diary < ApplicationRecord
    
    
    
 has_many_attached :image
 belongs_to :cat
 belongs_to :user
 
 
 

end
