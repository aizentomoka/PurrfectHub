class ChangeDatatypeAgeOfRescuedCats < ActiveRecord::Migration[6.1]
  def change
    change_column :rescued_cats, :age, :string
  end
end
