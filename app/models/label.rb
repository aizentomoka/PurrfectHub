class Label < ApplicationRecord
    
 has_many :labelings, dependent: :destroy
 has_many :rescued_cats, through: :labelings
 
 
  validates :name, length: {maximum: 6}, presence: true
  
end
