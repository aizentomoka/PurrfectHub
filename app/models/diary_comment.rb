class DiaryComment < ApplicationRecord
    
    
 
  belongs_to :user
  belongs_to :diary
  
  validates :comment, length: {maximum: 500}, presence: true
 
end
