class Label < ApplicationRecord
    
 has_many :labelings, dependent: :destroy
 has_many :rescued_cats, through: :labelings
    
end
