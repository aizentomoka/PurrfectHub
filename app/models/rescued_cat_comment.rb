class RescuedCatComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :rescued_cat
  
  validates :comment, length: {maximum: 500}, presence: true
  
end
