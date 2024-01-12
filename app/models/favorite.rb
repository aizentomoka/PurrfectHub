class Favorite < ApplicationRecord
    
    belongs_to :user
    belongs_to :diary
    
   validates :user_id, uniqueness: {scope: :diary_id} 
      
end
