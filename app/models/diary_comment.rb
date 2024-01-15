class DiaryComment < ApplicationRecord
    
    
 
  belongs_to :user
  belongs_to :diary
  
  validates :comment, length: {maximum: 50}, presence: true
 
end
