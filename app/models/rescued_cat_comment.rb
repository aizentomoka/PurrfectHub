class RescuedCatComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :rescued_cat
  
  validates :comment, length: {maximum: 50}, presence: true
  
end
