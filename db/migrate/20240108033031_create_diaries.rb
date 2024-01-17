class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.integer :cat_id
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.float :weight
      

      t.timestamps
    end
  end
end
