class RescuedCatComment < ApplicationRecord
    
  belongs_to :user
  belongs_to :rescued_cat
end
