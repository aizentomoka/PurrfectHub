class Labeling < ApplicationRecord
  
  belongs_to :rescued_cat
  belongs_to :label
  
end
