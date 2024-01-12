class CreateRescuedCatComments < ActiveRecord::Migration[6.1]
  def change
    create_table :rescued_cat_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :rescued_cat_id

      t.timestamps
    end
  end
end
