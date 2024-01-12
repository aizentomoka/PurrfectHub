class Bookmark < ApplicationRecord
    
   belongs_to :user
   belongs_to :rescued_cat
    
   validates :user_id, uniqueness: {scope: :rescued_cat_id}   
   
end
