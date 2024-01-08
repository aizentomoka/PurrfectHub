class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.date :birthday
      t.string :sex, null: false

      t.timestamps
    end
  end
end
